import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/pages/first_page.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

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
                  text: joinGroupProvider.pageIndex == 0
                      ? 'Join a group'
                      : joinGroupProvider.pageIndex == 1
                          ? 'Sign in or Sign up'
                          : 'Sign up',
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 28,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: joinGroupProvider.controller,
              onPageChanged: (int index) {
                setState(() {
                  joinGroupProvider.pageIndex = index;
                });
              },
              children: [
                FirsPageJoin(controller: joinGroupProvider.controller),
              ],
            ),
          ),
          if (stripePaymentProvider.isPaying)
            const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            ) else 
          NextButton(
            onPressed: joinGroupProvider.nextPressedJoin(
              context,
              userId,
            ),
          ),
          joinGroupProvider.pageIndex == 1
              ? const SizedBox(height: 0)
              : const SizedBox(height: kDefaultPadding / 4)
        ],
      ),
    );
  }
}
