import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

void confirmRequestPayoutDialog(BuildContext rootContext) {
  final authProvider = Provider.of<AuthProvider>(rootContext, listen: false);
  final appLocalizations = AppLocalizations.of(rootContext);
  if (authProvider.user == null) {
    return;
  }
  showCupertinoDialog(
    context: rootContext,
    builder: (BuildContext newContext) {
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
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: StaticText(
            text: appLocalizations.requestPayoutText,
            maxLines: 6,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actions: [
          NextButton(
            text: appLocalizations.no,
            textColor: GPColors.red,
            borderColor: GPColors.transparent,
            onPressed: () {
              Provider.of<MixPanelProvider>(newContext, listen: false)
                  .logEvent(eventName: 'Cancel Request Payout');
              Navigator.of(newContext).pop();
            },
            color: GPColors.transparent,
            height: 40,
            width: 140,
          ),
          NextButton(
            text: appLocalizations.yes,
            borderColor: GPColors.primaryColor,
            onPressed: () async {
              Provider.of<MixPanelProvider>(newContext, listen: false)
                  .logEvent(eventName: 'Request Payout');
              Navigator.of(newContext).pop();
              ScaffoldMessenger.of(rootContext).showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.payoutSuccessful),
                  duration: const Duration(seconds: 3),
                ),
              );
              try {
                for (var i = 0;
                    i < authProvider.user!.paymentIntentIds.length;
                    i++) {
                  final userPaymentIntentsIds = authProvider.user!.paymentIntentIds[i];
                  final retrievePaymentIntent = await FirebaseFunctions.instance
                      .httpsCallable('RetrivePaymentIntent')
                      .call(
                    {
                      'paymentIntentId': userPaymentIntentsIds,
                    },
                  );
                  await FirebaseFunctions.instance
                      .httpsCallable('CreateTransferStripe')
                      .call(
                    {
                      'accountId': authProvider.user!.stripeAccountId,
                      'amount': retrievePaymentIntent
                          .data['paymentIntentAmountReceived'],
                      'paymentIntentId': userPaymentIntentsIds,
                    },
                  );
                }
              } on FirebaseFunctionsException catch (e) {
                debugPrint(e.message);
              }
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(authProvider.user!.id)
                  .update(
                {
                  'paymentIntentIds': FieldValue.arrayRemove(
                    authProvider.user!.paymentIntentIds,
                  ),
                  'balance': 0,
                },
              );
            },
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
