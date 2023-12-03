import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/core/widgets/texts/gu_text_header.dart';
import 'package:groupup/screens/balance/components/confirm_delete_account_dialog.dart';
import 'package:groupup/screens/balance/components/confirm_login_to_account_dialog.dart';
import 'package:groupup/screens/balance/components/confirm_request_payout_dialog.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void payoutOrConnectedAccountOptionsDialog(BuildContext rootContext) {
  final authProvider = Provider.of<AuthProvider>(rootContext, listen: false);
  final appLocalizations = AppLocalizations.of(rootContext);
  if (authProvider.user == null) {
    return;
  }
  showCupertinoDialog(
    context: rootContext,
    builder: (BuildContext newContext) {
      return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: authProvider.user?.id)
            .snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs.first.data()['balance'];
          return AlertDialog(
            titlePadding: const EdgeInsets.only(
              top: 20,
              left: 10,
              right: 10,
            ),
            title: GUTextHeader(
              text: appLocalizations.chooseOption,
              textAlign: TextAlign.center,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Divider(
                  color: GPColors.secondaryColor,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ButtonCommonStyle(
                    onPressed: () {
                      Navigator.of(newContext).pop();
                      if (data == 0) {
                        ScaffoldMessenger.of(rootContext).showSnackBar(
                          SnackBar(
                            content: Text(appLocalizations.balanceZero),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      } else {
                        confirmRequestPayoutDialog(rootContext);
                      }
                    },
                    child: GUTextBody(
                      text: appLocalizations.requestPayout,
                      textAlign: TextAlign.center,
                      minFontSize: 18,
                      maxFontSize: 18,
                    ),
                  ),
                ),
                const Divider(
                  color: GPColors.secondaryColor,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ButtonCommonStyle(
                    onPressed: () async {
                      Navigator.of(newContext).pop();
                      confirmLoginToAccountDialog(context);
                    },
                    child: GUTextBody(
                      text: appLocalizations.loginToYourConnectedAccount,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      minFontSize: 18,
                      maxFontSize: 18,
                    ),
                  ),
                ),
                const Divider(
                  color: GPColors.secondaryColor,
                  thickness: 0.5,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ButtonCommonStyle(
                    onPressed: () {
                      Navigator.of(newContext).pop();
                      confirmDeleteAccountDialog(rootContext);
                    },
                    child: GUTextBody(
                      text: appLocalizations.deleteConnectedAccount,
                      textAlign: TextAlign.center,
                      minFontSize: 18,
                      maxFontSize: 18,
                    ),
                  ),
                ),
                const Divider(
                  color: GPColors.secondaryColor,
                  thickness: 0.5,
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: const EdgeInsets.only(
              bottom: 5,
              right: 10,
              left: 10,
            ),
            contentPadding: const EdgeInsets.only(
              top: 5,
              bottom: 5,
            ),
            actions: [
              GPButton(
                text: appLocalizations.cancel,
                textColor: GPColors.red,
                borderColor: GPColors.transparent,
                onPressed: () => Navigator.of(newContext).pop(),
                color: GPColors.transparent,
                height: 40,
                width: 140,
              ),
            ],
          );
        },
      );
    },
  );
}
