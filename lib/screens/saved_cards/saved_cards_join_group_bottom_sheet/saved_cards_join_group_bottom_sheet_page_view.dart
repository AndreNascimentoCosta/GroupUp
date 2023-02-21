import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/screens/saved_cards/saved_cards_join_group_bottom_sheet/saved_cards_join_group_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SavedCardsJoinGroupBottomSheetPageView extends StatelessWidget {
  const SavedCardsJoinGroupBottomSheetPageView({required this.groupCode});

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
          SavedCardsJoinGroupBottomSheetBody(groupCode: groupCode),
          const SizedBox(height: kDefaultPadding / 2),
          NextButton(
            onPressed: () async {
              final navigatorState = Navigator.of(context);
              final joinGroupProvider = Provider.of<JoinGroupProvider>(
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
                await stripePaymentProvider.initPaymentJoinGroup(
                  groupCode,
                  user.id,
                );
                // ignore: use_build_context_synchronously
                await joinGroupProvider.joinGroup(context);
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
