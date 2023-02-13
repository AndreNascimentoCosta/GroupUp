import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void confirmDelete(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: StaticText(
            text: appLocalizations.confirm,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: StaticText(
            text: appLocalizations.confirmDeleteAccount,
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: appLocalizations.yes,
              borderColor: Colors.transparent,
              color: Colors.transparent,
              onPressed: () => {
                authProvider.signOut(),
                Navigator.of(context).pop(),
              },
              textColor: kPrimaryColor,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: appLocalizations.no,
              textColor: Colors.white,
              borderColor: Colors.red,
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.red,
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
  }