import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/texts/static_text.dart';

class ReportParticipantProvider extends ChangeNotifier {
  final reportParticipantController = TextEditingController();

  ReportParticipantProvider() {
    reportParticipantController.addListener(notifyListeners);
  }

  void Function()? done(BuildContext context) {
    final nameText = reportParticipantController.text;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if ((nameText.isEmpty)) {
      return null;
    } else {
      return () {
        {
          authProvider.updateProfileName(reportParticipantController.text);
          Navigator.pop(context);
        }
      };
    }
  }

  void confirmDiscard(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        final appLocalizations = AppLocalizations.of(context);
        FocusScope.of(context).unfocus();
        return AlertDialog(
          title: StaticText(
            text: appLocalizations.discardChangesQuestion,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StaticText(
            text: appLocalizations.areYouSureToDiscardChanges,
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: appLocalizations.yesDiscard,
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(newContext);
                Navigator.pop(context);
              },
              color: Colors.transparent,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: appLocalizations.noKeep,
              borderColor: kPrimaryColor,
              onPressed: () {
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

  void Function()? back(BuildContext context) {
    final nameText = reportParticipantController.text;

    if ((nameText.isEmpty)) {
      return null;
    } else {
      return () => {
            confirmDiscard(context),
          };
    }
  }
}