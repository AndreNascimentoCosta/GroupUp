import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/pages/first_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/first_page.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/styles/text.dart';

class JoinPageView extends StatefulWidget {
  const JoinPageView({super.key});

  @override
  State<JoinPageView> createState() => _JoinPageViewState();
}

class _JoinPageViewState extends State<JoinPageView> {
  int pageIndex = 0;
  final controller = PageController(initialPage: 0);
  final itemCount = 3;
  bool isPageTwo = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null && mounted) {
        Navigator.pop(context);
      }
    });
  }

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
                text: pageIndex == 0
                    ? 'Join a group'
                    : pageIndex == 1
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
            controller: controller,
            onPageChanged: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: [
              FirsPageJoin(controller: controller),
              FirsPageSignUp(controller: controller),
            ],
          ),
        ),
        pageIndex == 1
            ? const SizedBox()
            : NextButton(
                onPressed: () {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
              ),
        pageIndex == 1
            ? const SizedBox(height: 0)
            : const SizedBox(height: Insets.l * 1.5)
      ],
    );
  }
}
