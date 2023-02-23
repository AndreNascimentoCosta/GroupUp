import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/screens/saved_cards/saved_cards_create_group_bottom_sheet/saved_cards_create_group_bottom_sheet.dart';
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
    final appLocalizations = AppLocalizations.of(context);
    final isPaying = Provider.of<StripePaymentProvider>(context).isPaying;
    if (isPaying) {
      return const Center(
        child: CircularProgressIndicator(color: kPrimaryColor),
      );
    }
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: StaticText(
              text: appLocalizations.savedCards,
              fontFamily: 'Montserrat-SemiBold',
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
          NextButton(
            onPressed: () async {
              Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                  eventName: 'Create Group Paying with Stripe Bottom Sheet');
              final navigatorState = Navigator.of(context);
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
                await stripePaymentProvider.initPaymentCreateGroup(
                  context,
                  user.id,
                  groupReward,
                  groupCurrency,
                );
                // ignore: use_build_context_synchronously
                await createGroupProvider.createGroup(context);
                navigatorState.pop();
                navigatorState.pop();
              } catch (e) {
                // ignore: avoid_print
                print(e);
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
