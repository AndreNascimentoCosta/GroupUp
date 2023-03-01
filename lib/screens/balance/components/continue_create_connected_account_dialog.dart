import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/next_button.dart';
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
          child: StaticText(
            text: appLocalizations.chooseOption,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
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
                child: StaticText(
                  text: appLocalizations.resumeAccountCreation,
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
                  Provider.of<MixPanelProvider>(context, listen: false)
                      .logEvent(eventName: 'Confirm Delete Connected Account');
                  Navigator.of(context).pop();
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
                        content: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kDefaultPadding),
                          child: StaticText(
                            text: appLocalizations.deleteConnectedAccountText,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            fontSize: TextSize.mBody,
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        contentPadding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                        actions: [
                          NextButton(
                            text: appLocalizations.no,
                            textColor: Colors.red,
                            borderColor: Colors.transparent,
                            onPressed: () {
                              Provider.of<MixPanelProvider>(context,
                                      listen: false)
                                  .logEvent(
                                      eventName:
                                          'Cancel Delete Connected Account');
                              Navigator.of(context).pop();
                            },
                            color: Colors.transparent,
                            height: 40,
                            width: 140,
                          ),
                          NextButton(
                            text: appLocalizations.yes,
                            borderColor: kPrimaryColor,
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
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: 'Cancel Continue Create Connected Account');
              Navigator.of(context).pop();
            },
            color: Colors.transparent,
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
