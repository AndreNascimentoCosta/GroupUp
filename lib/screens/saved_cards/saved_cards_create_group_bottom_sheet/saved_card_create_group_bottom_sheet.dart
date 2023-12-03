import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/stripe_payment_provider.dart';

class SavedCardCreateGroupBottomSheet extends StatelessWidget {
  const SavedCardCreateGroupBottomSheet({
    required this.last4Numbers,
    required this.brand,
    required this.expMonth,
    required this.expYear,
    required this.groupReward,
    required this.groupCurrency,
    required this.paymentMethodId,
    required this.groupCode,
  });

  final String last4Numbers;
  final String brand;
  final int expMonth;
  final int expYear;
  final String groupReward;
  final String groupCurrency;
  final String paymentMethodId;
  final String groupCode;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final user = Provider.of<AuthProvider>(context).user;
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return FutureBuilder(
      future:
          FirebaseFunctions.instance.httpsCallable('ListPaymentMethods').call(
        {
          'userId': user.id,
        },
      ),
      builder: (context, snapshot) {
        return ButtonCommonStyle(
          onPressed: () async {
            final stripePayment =
                Provider.of<StripePaymentProvider>(context, listen: false);
            Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                eventName: 'Confirm Create Group Paying with Saved Card');
            await stripePayment.savedCardConfirmCardCreateGroup(
              context,
              groupReward,
              groupCurrency,
              paymentMethodId,
              groupCode,
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
              vertical: kDefaultPadding / 2,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.credit_card,
                  color: GPColors.secondaryColor,
                  size: 30,
                ),
                const SizedBox(width: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GUTextBody(text: brand),
                    const SizedBox(height: kDefaultPadding / 2),
                    GUTextBody(
                      text: '**** **** **** $last4Numbers',
                      color: GPColors.secondaryColor,
                    ),
                  ],
                ),
                const SizedBox(width: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GUTextBody(text: appLocalizations.expDate),
                    const SizedBox(height: kDefaultPadding / 2),
                    GUTextBody(
                      text: '$expMonth/$expYear',
                      color: GPColors.secondaryColor,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const GPIcon(
                      GPIcons.arrowLeft,
                      color: GPColors.secondaryColor,
                      height: Insets.l * 1.25,
                      width: Insets.l * 1.25,
                    ),
                  ),
                ),
                const SizedBox(width: kDefaultPadding / 2),
              ],
            ),
          ),
        );
      },
    );
  }
}
