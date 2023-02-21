// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

showDialogIfFirstOpened(BuildContext context) async {
  const keyIsFirstOpened = 'is_first_opened';
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isFirstLoaded = prefs.getBool(keyIsFirstOpened);
  final appLocalizations = AppLocalizations.of(context);
  if (isFirstLoaded == null) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: StaticText(
            text: appLocalizations.tieBreaker,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StaticText(
            text: appLocalizations
                .tieBreakerText,
            maxLines: 8,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            ButtonCommonStyle(
              onPressed: () {
                Navigator.of(context).pop();
                prefs.setBool(keyIsFirstOpened, false);
              },
              child: const StaticText(
                text: 'OK',
                fontSize: TextSize.mBody,
                color: kPrimaryColor,
              ),
            )
          ],
        );
      },
    );
  }
}
