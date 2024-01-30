import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

void confirmRequestPayoutDialog(BuildContext rootContext) {
  final authProvider = Provider.of<AuthProvider>(rootContext, listen: false);
  final appLocalizations = AppLocalizations.of(rootContext)!;
  if (authProvider.user == null) {
    return;
  }
  showCupertinoDialog(
    context: rootContext,
    builder: (BuildContext newContext) {
      return AlertDialog(
        title: GPTextHeader(
          text: appLocalizations.confirm,
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GPTextBody(
            text: appLocalizations.requestPayoutText,
            maxLines: 6,
            textAlign: TextAlign.center,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actions: [
          GPButton(
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
          GPButton(
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
