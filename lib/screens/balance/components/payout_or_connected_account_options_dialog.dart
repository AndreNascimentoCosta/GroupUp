import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/balance/components/confirm_delete_account_dialog.dart';
import 'package:groupup/screens/balance/components/confirm_login_to_account_dialog.dart';
import 'package:groupup/screens/balance/components/confirm_request_payout_dialog.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void payoutOrConnectedAccountOptionsDialog(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context);
  if (authProvider.user == null) {
    return;
  }
  showCupertinoDialog(
    context: context,
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
              title: StaticText(
                text: appLocalizations.chooseOption,
                textAlign: TextAlign.center,
                fontFamily: 'Montserrat-SemiBold',
                fontSize: TextSize.lBody,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(
                    color: kSecondaryColor,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ButtonCommonStyle(
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (data == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(appLocalizations.balanceZero),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                          ;
                        } else {
                          confirmRequestPayoutDialog(context);
                        }
                      },
                      child: StaticText(
                        text: appLocalizations.requestPayout,
                        textAlign: TextAlign.center,
                        fontSize: TextSize.lBody,
                      ),
                    ),
                  ),
                  const Divider(
                    color: kSecondaryColor,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ButtonCommonStyle(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        confirmLoginToAccountDialog(context);
                      },
                      child: StaticText(
                        text: appLocalizations.loginToYourConnectedAccount,
                        textAlign: TextAlign.center,
                        fontSize: TextSize.lBody,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  const Divider(
                    color: kSecondaryColor,
                    thickness: 0.5,
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: ButtonCommonStyle(
                      onPressed: () {
                        Navigator.of(context).pop();
                        confirmDeleteAccountDialog(context);
                      },
                      child: StaticText(
                        text: appLocalizations.deleteConnectedAccount,
                        textAlign: TextAlign.center,
                        fontSize: TextSize.lBody,
                      ),
                    ),
                  ),
                  const Divider(
                    color: kSecondaryColor,
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
                NextButton(
                  text: appLocalizations.cancel,
                  textColor: Colors.red,
                  borderColor: Colors.transparent,
                  onPressed: () => Navigator.of(context).pop(),
                  color: Colors.transparent,
                  height: 40,
                  width: 140,
                ),
              ],
            );
          });
    },
  );
}
