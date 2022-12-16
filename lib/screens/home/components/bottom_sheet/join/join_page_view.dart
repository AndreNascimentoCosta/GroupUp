import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/third_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/first_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/second_page.dart';
import 'package:groupup/screens/home/models/next_button.dart';
import 'package:groupup/styles/button.dart';
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
                          child: const ImageIcon(
                            AssetImage('assets/icons/arrow_left.png'),
                            color: Color(0xFF868686),
                          ))
                      : null,
                ),
              ),
              StandardTextStyle(
                text: pageIndex == 0 ?
                'Join a group' : 'Sign in or Sign up',
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
              FirsPageJoin(controller: controller, count: itemCount),
              SecondPageJoin(controller: controller, count: itemCount),
              const ThirdPageCreate(),
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
        const SizedBox(height: Insets.l * 1.5),
      ],
    );
  }
}
