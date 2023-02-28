import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/stripe_payment_provider.dart';

void savedCardConfirmCardJoinGroup(
  BuildContext context,
  String groupCode,
  String paymentMethodId,
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
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: StaticText(
            text: appLocalizations.confirmCard,
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: TextSize.mBody,
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
        actions: [
          NextButton(
            text: appLocalizations.no,
            textColor: Colors.red,
            borderColor: Colors.transparent,
            onPressed: () {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: 'Cancel Join Group Paying with Saved Card');
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
                  .logEvent(eventName: 'Join Group Paying with Saved Card');
              final stripePaymentProvider =
                  Provider.of<StripePaymentProvider>(context, listen: false);
              final user =
                  Provider.of<AuthProvider>(context, listen: false).user;
              if (user == null) {
                return;
              }
              final navigatorState = Navigator.of(context);
              final joinGroupProvider =
                  Provider.of<JoinGroupProvider>(context, listen: false);
              try {
                final paymentIntentId = await FirebaseFunctions.instance
                    .httpsCallable('StripePayEndPointMethodIdJoinGroup')
                    .call(
                  {
                    'groupCode': groupCode,
                    'userId': user.id,
                    'paymentMethodId': paymentMethodId,
                  },
                );
                await stripePaymentProvider.addPaymentIntentId(
                  paymentMethodId,
                  groupCode,
                );
              } on FirebaseFunctionsException catch (e) {
                // ignore: avoid_print
                print(e.code);
              }
              // ignore: use_build_context_synchronously
              joinGroupProvider.joinGroup(context);
              navigatorState.pop();
              navigatorState.pop();
              navigatorState.pop();
            },
            height: 40,
            width: 140,
          ),
        ],
      );
    },
  );
}
