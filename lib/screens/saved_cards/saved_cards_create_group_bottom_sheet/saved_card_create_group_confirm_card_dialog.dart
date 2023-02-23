// ignore_for_file: use_build_context_synchronously

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';

void savedCardConfirmCardCreateGroup(
  BuildContext context,
  String groupReward,
  String groupCurrency,
  String paymentMethodId,
  String groupCode,
) {
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
          text: appLocalizations.confirmCard,
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
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Cancel Create Group Paying with Saved Card');
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
              Provider.of<MixPanelProvider>(context, listen: false)
                  .logEvent(eventName: 'Create Group Paying with Saved Card');
              final user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              if (user == null) {
                return;
              }
              final navigatorState = Navigator.of(context);
              final createGroupProvider =
                  Provider.of<CreateGroupProvider>(context, listen: false);
              final stripePayment =
                  Provider.of<StripePaymentProvider>(context, listen: false);
              try {
                final paymentIntentId = await FirebaseFunctions.instance
                    .httpsCallable('StripePayEndPointMethodIdCreateGroup')
                    .call(
                  {
                    'userId': user.id,
                    'groupReward': groupReward,
                    'groupCurrency': groupCurrency,
                    'paymentMethodId': paymentMethodId,
                  },
                );
                await createGroupProvider.createGroup(context);
                navigatorState.pop();
                navigatorState.pop();
                navigatorState.pop();
                await stripePayment.addPaymentIntentId(
                  paymentIntentId.data['paymentIntentId'],
                  groupCode,
                );
              } on FirebaseFunctionsException catch (e) {
                // ignore: avoid_print
                print(e.code);
              }
              navigatorState.pop();
              createGroupProvider.controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
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
