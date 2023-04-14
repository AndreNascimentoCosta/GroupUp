import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                    StaticText(
                      text: brand,
                      fontSize: TextSize.mBody,
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    StaticText(
                      text: '**** **** **** $last4Numbers',
                      color: GPColors.secondaryColor,
                      fontSize: TextSize.mBody,
                    ),
                  ],
                ),
                const SizedBox(width: kDefaultPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StaticText(
                      text: appLocalizations.expDate,
                      fontSize: TextSize.mBody,
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    StaticText(
                      text: '$expMonth/$expYear',
                      color: GPColors.secondaryColor,
                      fontSize: TextSize.mBody,
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: SvgPicture.asset(
                      'assets/icons/arrow_right.svg',
                      height: Insets.l * 1.25,
                      width: Insets.l * 1.25,
                      color: GPColors.secondaryColor,
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
