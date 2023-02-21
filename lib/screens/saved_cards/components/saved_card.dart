import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedCard extends StatelessWidget {
  const SavedCard({
    required this.last4Numbers,
    required this.brand,
    required this.expMonth,
    required this.expYear,
  });

  final String last4Numbers;
  final String brand;
  final int expMonth;
  final int expYear;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
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
            child: ButtonCommonStyle(
              onPressed: () {},
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
