import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/stripe_payment_provider.dart';

void savedCardConfirmCardJoinGroup(
  BuildContext context,
  String groupCode,
  String paymentMethodId,
) {
  final appLocalizations = AppLocalizations.of(context)!;
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
            text: appLocalizations.confirmCard,
            maxLines: 2,
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
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: 'Cancel Join Group Paying with Saved Card');
              context.pop();
            },
            color: GPColors.transparent,
            height: 40,
            width: 140,
          ),
          GPButton(
            text: appLocalizations.yes,
            borderColor: GPColors.primaryColor,
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
              final navigatorState = context;
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
                  paymentIntentId.data['paymentIntentId'],
                  groupCode,
                );
              } on FirebaseFunctionsException catch (e) {
                debugPrint(e.code);
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
