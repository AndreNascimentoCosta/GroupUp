import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

void createConnectedAccount(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context);
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: StaticText(
          text: appLocalizations.connectedAccount,
          textAlign: TextAlign.center,
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: StaticText(
          text: appLocalizations.createConnectedAccountText,
          maxLines: 4,
          textAlign: TextAlign.center,
          fontSize: TextSize.mBody,
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
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
          NextButton(
            text: appLocalizations.createAccount,
            borderColor: kPrimaryColor,
            color: kPrimaryColor,
            onPressed: () async {
              {
                final navigatorState = Navigator.of(context);
                try {
                  final scaffoldMessengerState = ScaffoldMessenger.of(context);
                  navigatorState.pop();
                  scaffoldMessengerState.showSnackBar(
                    SnackBar(
                      content: Text(appLocalizations.redirecting),
                      duration: const Duration(seconds: 8),
                    ),
                  );
                  final accountLink = await FirebaseFunctions.instance
                      .httpsCallable('CreateAccount')
                      .call({});
                  final url = Uri.parse(
                    accountLink.data['accountLinkUrl'],
                  );
                  await authProvider.updateStripeAccountId(
                    accountLink.data['accountId'],
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.inAppWebView,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                } on FirebaseFunctionsException catch (e) {
                  navigatorState.pop();
                  // ignore: avoid_print
                  print(e.message);
                }
              }
            },
            textColor: Colors.white,
            height: 40,
            width: 160,
          ),
        ],
      );
    },
  );
}
