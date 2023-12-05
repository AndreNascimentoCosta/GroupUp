import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

void confirmLoginToAccountDialog(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context);
  showCupertinoDialog(
    context: context,
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
            text: appLocalizations.loginToYourConnectedAccountText,
            maxLines: 4,
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
                  .logEvent(eventName: 'Cancel Login to Account');
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
                  .logEvent(eventName: 'Login to Account');
              Navigator.of(newContext).pop();
              ScaffoldMessenger.of(newContext).showSnackBar(
                SnackBar(
                  content: Text(appLocalizations.redirecting),
                  duration: const Duration(milliseconds: 500),
                ),
              );
              try {
                final loginLink = await FirebaseFunctions.instance
                    .httpsCallable('LoginLink')
                    .call(
                  {
                    'accountId': authProvider.user!.stripeAccountId,
                  },
                );
                final url = Uri.parse(loginLink.data['loginLink']);
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.inAppWebView,
                  );
                } else {
                  throw 'Could not launch $url';
                }
              } on FirebaseFunctionsException catch (e) {
                debugPrint(e.message);
              }
            },
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
