import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void confirmDeleteAccountDialog(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context);
  showCupertinoDialog(
    context: context,
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
        content: StaticText(
          text: appLocalizations.deleteConnectedAccountText,
          maxLines: 2,
          textAlign: TextAlign.center,
          fontSize: TextSize.mBody,
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actions: [
          NextButton(
            text: appLocalizations.no,
            textColor: Colors.red,
            borderColor: Colors.transparent,
            onPressed: () => Navigator.of(newContext).pop(),
            color: Colors.transparent,
            height: 40,
            width: 140,
          ),
          NextButton(
            text: appLocalizations.yes,
            borderColor: kPrimaryColor,
            onPressed: () async {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.connectedAccountDeleted),
                  duration: const Duration(seconds: 2),
                ),
              );
              try {
                await FirebaseFunctions.instance
                    .httpsCallable('DeleteAccount')
                    .call(
                  {
                    'accountId': authProvider.user!.stripeAccountId,
                  },
                );
              } on FirebaseFunctionsException catch (e) {
                // ignore: avoid_print
                print(e.message);
              }
              // ignore: use_build_context_synchronously
              await Provider.of<StripePaymentProvider>(context, listen: false)
                  .deleteConnectedAccount(
                context,
                authProvider.user!.stripeAccountId,
              );
              authProvider.getUser();
            },
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
