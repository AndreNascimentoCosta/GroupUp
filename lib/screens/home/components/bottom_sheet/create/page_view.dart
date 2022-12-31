import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/pages/first_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/pages/second_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/pages/third_page.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/first_page.dart';
import 'package:groupup/screens/home/components/next_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/styles/text.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreatePageView extends StatefulWidget {
  const CreatePageView({super.key});

  @override
  State<CreatePageView> createState() => _CreatePageViewState();
}

class _CreatePageViewState extends State<CreatePageView> {
  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
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
                  child: createGroupProvider.pageIndex != 0
                      ? ButtonCommonStyle(
                          onPressed: () {
                            createGroupProvider.controller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease);
                          },
                          child: SizedBox(
                            height: Insets.xl,
                            width: Insets.xl,
                            child: SvgPicture.asset(
                              'assets/icons/arrow_left.svg',
                              color: const Color(0xFF868686),
                            ),
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
                        controller: createGroupProvider.controller,
                        count: createGroupProvider.itemCount,
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
            physics: const NeverScrollableScrollPhysics(),
            controller: createGroupProvider.controller,
            onPageChanged: createGroupProvider.updateIndex,
            children: [
              FirsPageCreate(controller: createGroupProvider.controller),
              SecondPageCreate(controller: createGroupProvider.controller),
              const ThirdPageCreate(),
              FirsPageSignUp(controller: createGroupProvider.controller),
            ],
          ),
        ),
        NextButton(
          onPressed: createGroupProvider.nextPressed(context),
        ),
        const SizedBox(height: Insets.l * 1.5),
      ],
    );
  }
}
