import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SavedCard extends StatelessWidget {
  const SavedCard({
    required this.last4Numbers,
    required this.brand,
    required this.expMonth,
    required this.expYear,
    required this.paymentMethodId,
  });

  final String last4Numbers;
  final String brand;
  final int expMonth;
  final int expYear;
  final String paymentMethodId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final user = Provider.of<AuthProvider>(context).user;
    if (user == null) return const SizedBox();
    return FutureBuilder(
      future:
          FirebaseFunctions.instance.httpsCallable('ListPaymentMethods').call(
        {
          'userId': user.id,
        },
      ),
      builder: (context, snapshot) {
        return Padding(
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
                child: ButtonCommonStyle(
                  onPressed: () async {
                    Provider.of<MixPanelProvider>(context, listen: false)
                        .logEvent(eventName: 'Delete Saved Card');
                    await FirebaseFunctions.instance
                        .httpsCallable('DetachPaymentMethod')
                        .call(
                      {
                        'paymentMethodId': paymentMethodId,
                      },
                    );
                  },
                  child: const Icon(
                    Icons.delete_outline_rounded,
                    color: GPColors.red,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
