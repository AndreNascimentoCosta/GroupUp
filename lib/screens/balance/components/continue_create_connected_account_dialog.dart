import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/providers/mix_panel_provider.dart';

void continueCreateConnectedAccountDialog(BuildContext context) {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final appLocalizations = AppLocalizations.of(context);
  if (authProvider.user == null) {
    return;
  }
  showCupertinoDialog(
    context: context,
    builder: (BuildContext newContext) {
      return AlertDialog(
        titlePadding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: GPTextHeader(
            text: appLocalizations.chooseOption,
            textAlign: TextAlign.center,
          ),
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
                onPressed: () async {
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Resume Account Creation');
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(appLocalizations.redirecting),
                      duration: const Duration(milliseconds: 500),
                    ),
                  );
                  try {
                    final accountLink = await FirebaseFunctions.instance
                        .httpsCallable('CreateAccountLink')
                        .call({
                      'accountId': authProvider.user!.stripeAccountId,
                    });
                    final url = Uri.parse(accountLink.data['accountLinkUrl']);
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
                child: GPTextBody(
                  text: appLocalizations.resumeAccountCreation,
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
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Confirm Delete Connected Account');
                  Navigator.of(context).pop();
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: GPTextBody(
                            text: appLocalizations.deleteConnectedAccountText,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                        actions: [
                          GPButton(
                            text: appLocalizations.no,
                            textColor: GPColors.red,
                            borderColor: GPColors.transparent,
                            onPressed: () {
                              Provider.of<MixPanelProvider>(context,
                                      listen: false)
                                  .logEvent(
                                      eventName:
                                          'Cancel Delete Connected Account');
                              Navigator.of(context).pop();
                            },
                            color: GPColors.transparent,
                            height: 40,
                            width: 140,
                          ),
                          GPButton(
                            text: appLocalizations.yes,
                            borderColor: GPColors.primaryColor,
                            onPressed: () async {
                              Provider.of<MixPanelProvider>(context,
                                      listen: false)
                                  .logEvent(
                                      eventName: 'Delete Connected Account');
                              Navigator.of(newContext).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    appLocalizations.connectedAccountDeleted,
                                  ),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              try {
                                await FirebaseFunctions.instance
                                    .httpsCallable('DeleteAccount')
                                    .call({
                                  'accountId':
                                      authProvider.user!.stripeAccountId,
                                });
                              } on FirebaseFunctionsException catch (e) {
                                debugPrint(e.message);
                              }
                              // ignore: use_build_context_synchronously
                              await Provider.of<StripePaymentProvider>(context,
                                      listen: false)
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
                },
                child: GPTextBody(
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
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: 'Cancel Continue Create Connected Account');
              Navigator.of(context).pop();
            },
            color: GPColors.transparent,
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
