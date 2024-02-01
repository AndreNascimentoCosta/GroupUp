import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/modules/saved_cards/saved_cards_create_group_bottom_sheet/saved_cards_create_group_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SavedCardsCreateGroupBottomSheetPageView extends StatelessWidget {
  const SavedCardsCreateGroupBottomSheetPageView({
    required this.groupReward,
    required this.groupCurrency,
    required this.groupCode,
  });

  final String groupReward;
  final String groupCurrency;
  final String groupCode;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final stripePaymentProvider = Provider.of<StripePaymentProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: GPTextHeader(
              text: appLocalizations.savedCards,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          SavedCardsCreateGroupBottomSheetBody(
            groupReward: groupReward,
            groupCurrency: groupCurrency,
            groupCode: groupCode,
          ),
          const SizedBox(height: kDefaultPadding / 2),
          if (stripePaymentProvider.isPaying == true)
            const GPLoading()
          else
            GPButton(
              onPressed: () async {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Create Group Paying with Stripe Bottom Sheet');
                final navigatorState = context;
                final createGroupProvider = Provider.of<CreateGroupProvider>(
                  context,
                  listen: false,
                );
                final user =
                    Provider.of<AuthProvider>(context, listen: false).user;
                if (user == null) {
                  return;
                }
                try {
                  final stripePaymentProvider =
                      Provider.of<StripePaymentProvider>(
                    context,
                    listen: false,
                  );
                  final paymentIntentId =
                      await stripePaymentProvider.initPaymentCreateGroup(
                    context,
                    user.id,
                    groupReward,
                    groupCurrency,
                  );
                  await createGroupProvider.createGroup(user);
                  await stripePaymentProvider.addPaymentIntentId(
                    paymentIntentId,
                    createGroupProvider.newGroup.groupCode,
                  );
                  navigatorState.pop();
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              width: 250,
              text: 'Other payment methods',
            ),
        ],
      ),
    );
  }
}