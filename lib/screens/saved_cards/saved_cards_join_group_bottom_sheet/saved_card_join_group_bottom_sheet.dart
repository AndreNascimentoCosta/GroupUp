import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/providers/stripe_payment_provider.dart';

class SavedCardJoinGroupBottomSheet extends StatelessWidget {
  const SavedCardJoinGroupBottomSheet({
    required this.last4Numbers,
    required this.brand,
    required this.expMonth,
    required this.expYear,
    required this.groupCode,
    required this.paymentMethodId,
  });

  final String last4Numbers;
  final String brand;
  final int expMonth;
  final int expYear;
  final String groupCode;
  final String paymentMethodId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final user = Provider.of<AuthProvider>(context).user;
    if (user == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return ButtonCommonStyle(
      onPressed: () {
        final stripePaymentProvider = Provider.of<StripePaymentProvider>(
          context,
          listen: false,
        );
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'Confirm Join Group Paying with Saved Card');
        stripePaymentProvider.savedCardConfirmCardJoinGroup(
          context,
          groupCode,
          paymentMethodId,
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
                child: const GPIcon(
                  GPIcons.arrowRight,
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
  }
}
