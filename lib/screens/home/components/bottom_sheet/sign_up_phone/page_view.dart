import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up_phone/pages/first_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up_phone/pages/second_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up_phone/pages/third_page.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/styles/text.dart';

class SignUpPhonePageView extends StatefulWidget {
  const SignUpPhonePageView({super.key});

  @override
  State<SignUpPhonePageView> createState() => _SignUpPhonePageViewState();
}

class _SignUpPhonePageViewState extends State<SignUpPhonePageView> {
  int pageIndex = 0;
  final controller = PageController(initialPage: 0);
  final itemCount = 3;
  bool isPageTwo = false;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  child: pageIndex != 0
                      ? ButtonCommonStyle(
                          onPressed: () {
                            controller.previousPage(
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
              StandardTextStyle(
                textAlign: TextAlign.center,
                text: pageIndex < 2 ? 'Sign up' : 'Verification code',
                fontFamily: 'Montserrat-SemiBold',
                fontSize: 28,
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            controller: controller,
            onPageChanged: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: [
              FirstPageSignUpPhone(controller: controller),
              Center(child: SecondPageSignUpPhone(controller: controller)),
              ThirdPageSignUpPhone(controller: controller),
            ],
          ),
        ),
        pageIndex != 2
            ? NextButton(
                onPressed: () {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
              )
            : NextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: ((context) =>
                              GroupsScreen(homeViewModel: HomeViewModel()))),
                      (route) => false);
                },
              ),
        const SizedBox(height: Insets.l * 1.5)
      ],
    );
  }
}
