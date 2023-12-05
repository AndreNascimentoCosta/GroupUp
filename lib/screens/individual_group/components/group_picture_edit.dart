import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
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
        gpModalBottomSheet(
          context,
          context.screenHeight * 0.185,
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kDefaultPadding * 1.75,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCommonStyle(
                  onPressed: onPressedGallery,
                  child: GPTextBody(
                    text: appLocalizations.chooseFromGallery,
                    textAlign: TextAlign.center,
                    minFontSize: 16,
                    maxFontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: Insets.l * 1.75,
                ),
                ButtonCommonStyle(
                  onPressed: onPressedCamera,
                  child: GPTextBody(
                    text: appLocalizations.takePhoto,
                    textAlign: TextAlign.center,
                    minFontSize: 16,
                    maxFontSize: 18,
                  ),
                )
              ],
            ),
          ),
        );
      },
      child: child,
    );
  }
}
