import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/pages/first_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/pages/second_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/pages/third_page.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/styles/text.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreatePageView extends StatefulWidget {
  const CreatePageView({super.key});

  @override
  State<CreatePageView> createState() => _CreatePageViewState();
}

class _CreatePageViewState extends State<CreatePageView> {
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
              const StandardTextStyle(
                text: 'Create a group',
                fontFamily: 'Montserrat-SemiBold',
                fontSize: 28,
              ),
              Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: SmoothPageIndicator(
                        controller: controller,
                        count: itemCount,
                        effect: const WormEffect(
                          dotHeight: 10,
                          dotWidth: 10,
                          dotColor: Color(0xFFD9D9D9),
                          activeDotColor: Color(0xFF868686),
                          type: WormType.thin,
                        ))),
              )
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
              FirsPageCreate(controller: controller, count: itemCount),
              SecondPageCreate(controller: controller, count: itemCount),
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
