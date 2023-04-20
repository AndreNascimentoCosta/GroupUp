import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/screens/create_group/pages/first_page.dart';
import 'package:groupup/screens/create_group/pages/review_create_group.dart';
import 'package:groupup/screens/create_group/pages/second_page.dart';
import 'package:groupup/screens/create_group/pages/third_page.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/providers/mix_panel_provider.dart';

class CreatePageView extends StatefulWidget {
  const CreatePageView({super.key});

  @override
  State<CreatePageView> createState() => _CreatePageViewState();
}

class _CreatePageViewState extends State<CreatePageView> {
  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 350;
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
                    child: createGroupProvider.pageIndex != 0 &&
                            createGroupProvider.pageIndex != 3
                        ? ButtonCommonStyle(
                            onPressed: () {
                              Provider.of<MixPanelProvider>(context,
                                      listen: false)
                                  .logEvent(
                                      eventName: 'Back Button Create Group');
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
                            ),
                          )
                        : null,
                  ),
                ),
                StaticText(
                  text: AppLocalizations.of(context).createGroup,
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: isVerySmallScreen ? 24 : 28,
                ),
                if (Provider.of<CreateGroupProvider>(context, listen: false)
                        .pageIndex ==
                    3)
                  const SizedBox()
                else
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
                        ),
                      ),
                    ),
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
                ReviewCreateGroup(controller: createGroupProvider.controller),
                const ThirdPageCreate(),
              ],
            ),
          ),
          const SizedBox(height: kDefaultPadding / 2),
          createGroupProvider.isPaying
              ? const CircularProgressIndicator.adaptive()
              : createGroupProvider.isCreatingGroup
                  ? const SizedBox()
                  : GPButton(
                      onPressed: createGroupProvider.nextPressedCreate(context),
                    ),
          const SizedBox(height: kDefaultPadding / 4),
        ],
      ),
    );
  }
}
