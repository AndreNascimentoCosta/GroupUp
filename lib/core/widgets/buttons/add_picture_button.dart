import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:provider/provider.dart';

class AddPicture extends StatelessWidget {
  const AddPicture({
    required this.onPressedGallery,
    required this.onPressedCamera,
    required this.child,
  });

  final void Function() onPressedGallery;
  final void Function() onPressedCamera;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ButtonCommonStyle(
      onPressed: () {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Add Profile Picture');
        gpModalBottomSheet(
          context,
          context.screenHeight * 0.185,
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.75),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonCommonStyle(
                  onPressed: onPressedGallery,
                  child: GPTextBody(
                    text: appLocalizations.chooseFromGallery,
                    textAlign: TextAlign.center,
                    fontSize: 16,
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
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        );
      },
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          CircleAvatar(
              radius: context.screenHeight * 0.06,
              backgroundColor: const Color(0XFFE1E1E1),
              child: child),
        ],
      ),
    );
  }
}
