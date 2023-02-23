import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/mix_panel_provider.dart';

class GroupPictureEdit extends StatelessWidget {
  const GroupPictureEdit({
    required this.onPressedGallery,
    required this.onPressedCamera,
    required this.child,
  });

  final void Function() onPressedGallery;
  final void Function() onPressedCamera;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return ButtonCommonStyle(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Edit Group Picture');
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Insets.m),
          ),
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Wrap(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.17,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: kDefaultPadding * 1.75),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonCommonStyle(
                                onPressed: onPressedGallery,
                                child: LargeBody(
                                  text: appLocalizations.chooseFromGallery,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(height: Insets.l * 1.75),
                              ButtonCommonStyle(
                                onPressed: onPressedCamera,
                                child: LargeBody(
                                  text: appLocalizations.takePhoto,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
      child: child,
    );
  }
}
