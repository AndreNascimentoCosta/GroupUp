import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/providers/mix_panel_provider.dart';

void createConnectedAccount(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context)!;
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: GPTextHeader(
          text: appLocalizations.connectedAccount,
          textAlign: TextAlign.center,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GPTextBody(
            text: appLocalizations.createConnectedAccountText,
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        actions: [
          GPButton(
            text: appLocalizations.cancel,
            textColor: GPColors.red,
            borderColor: GPColors.transparent,
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Cancel Create connected account');
              context.pop();
            },
            color: GPColors.transparent,
            height: 40,
            width: 100,
          ),
          GPButton(
            text: appLocalizations.createAccount,
            borderColor: GPColors.primaryColor,
            color: GPColors.primaryColor,
            onPressed: () async {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Create connected account');
              {
                final navigatorState = context;
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
                      mode: Platform.isAndroid
                          ? LaunchMode.externalApplication
                          : LaunchMode.inAppWebView,
                    );
                  } else {
                    throw 'Could not launch $url';
                  }
                } on FirebaseFunctionsException catch (e) {
                  navigatorState.pop();
                  debugPrint(e.message);
                }
              }
            },
            textColor: GPColors.white,
            height: 40,
            width: 160,
          ),
        ],
      );
    },
  );
}
