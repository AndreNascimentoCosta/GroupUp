import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/join/pages/first_page.dart';
import 'package:groupup/screens/join/pages/review_join_group.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/providers/mix_panel_provider.dart';

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
                            child: SvgPicture.asset(
                              'assets/icons/arrow_left.svg',
                              color: const Color(0xFF868686),
                            ))
                        : null,
                  ),
                ),
                StaticText(
                  text: AppLocalizations.of(context).joinAGroup,
                  fontFamily: 'Montserrat-SemiBold',
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
