import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'mix_panel_provider.dart';

class EditProfileNameProvider extends ChangeNotifier {
  final profileNameController = TextEditingController();

  EditProfileNameProvider(String initialText) {
    profileNameController.addListener(notifyListeners);
    profileNameController.text = initialText;
  }

  void Function()? done(BuildContext context) {
    final nameText = profileNameController.text;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if ((nameText.isEmpty || nameText.length < 3 || nameText.length >= 30)) {
      return null;
    } else {
      return () {
        {
          Provider.of<MixPanelProvider>(context, listen: false)
              .logEvent(eventName: 'Update profile name');
          authProvider.updateProfileName(profileNameController.text);
          Navigator.pop(context);
        }
      };
    }
  }

  void confirmDiscard(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        final appLocalizations = AppLocalizations.of(context)!;
        FocusScope.of(context).unfocus();
        return AlertDialog(
          title: GPTextHeader(
            text: appLocalizations.discardChangesQuestion,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GPTextBody(
              text: appLocalizations.areYouSureToDiscardChanges,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            GPButton(
              text: appLocalizations.yesDiscard,
              textColor: GPColors.red,
              borderColor: GPColors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Discard changes in Edit Profile Name');
                Navigator.pop(newContext);
                Navigator.pop(context);
              },
              color: GPColors.transparent,
              height: 40,
              width: 140,
            ),
            GPButton(
              text: appLocalizations.noKeep,
              borderColor: GPColors.primaryColor,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Keep changes in Edit Profile Name');
                Navigator.of(newContext).pop();
                FocusScope.of(context).requestFocus();
              },
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
  }
}
