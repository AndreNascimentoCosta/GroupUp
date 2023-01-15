import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';

void confirmDelete(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const StaticText(
            text: 'Confirm',
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: const StaticText(
            text: 'Are you sure you want to delete \nyour account?',
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: 'Yes',
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
              text: 'No',
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