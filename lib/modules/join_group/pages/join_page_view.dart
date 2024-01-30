import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/screens/join_group/components/first_page.dart';
import 'package:groupup/screens/join_group/components/review_join_group.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class JoinPageView extends StatefulWidget {
  const JoinPageView({super.key});

  @override
  State<JoinPageView> createState() => _JoinPageViewState();
}

class _JoinPageViewState extends State<JoinPageView> {
  @override
  Widget build(BuildContext context) {
    final joinGroupProvider = Provider.of<JoinGroupProvider>(context);
    final stripePaymentProvider = Provider.of<StripePaymentProvider>(context);
    final userId = Provider.of<AuthProvider>(context).user?.id ?? '';
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kDefaultPadding * 2),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: joinGroupProvider.pageIndex != 0
                        ? ButtonCommonStyle(
                            onPressed: () {
                              Provider.of<MixPanelProvider>(context,
                                      listen: false)
                                  .logEvent(eventName: 'Back Button Join');
                              joinGroupProvider.controller.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease);
                            },
                            child: const GPIcon(
                              GPIcons.arrowLeft,
                              color: GPColors.secondaryColor,
                            ),
                          )
                        : null,
                  ),
                ),
                GPTextHeader(
                  text: AppLocalizations.of(context)!.joinAGroup,
                  fontSize: 28,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: joinGroupProvider.controller,
              onPageChanged: joinGroupProvider.updateIndex,
              children: [
                FirstPageJoin(controller: joinGroupProvider.controller),
                ReviewJoinGroup(controller: joinGroupProvider.controller),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          if (stripePaymentProvider.isPaying ||
              joinGroupProvider.isOpeningSavedCards)
            const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          else
            GPButton(
              onPressed: joinGroupProvider.nextPressedJoin(
                context,
                userId,
              ),
            ),
          const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
