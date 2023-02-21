import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:groupup/screens/saved_cards/saved_cards_join_group_bottom_sheet/saved_card_join_group_confirm_card_dialog.dart';
import 'package:provider/provider.dart';

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
        child: CircularProgressIndicator(color: kPrimaryColor),
      );
    }
    return ButtonCommonStyle(
      onPressed: () {
        savedCardConfirmCardJoinGroup(
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
              color: kSecondaryColor,
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
                  color: kSecondaryColor,
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
                  color: kSecondaryColor,
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
                  color: kSecondaryColor,
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