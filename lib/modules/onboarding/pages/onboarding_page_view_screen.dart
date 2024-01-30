import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/animations/rive_animations.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/page_indicator/gp_page_indicator.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/modules/groups/screens/groups_screen.dart';
import 'package:groupup/modules/onboarding/components/app_bar_onboarding.dart';
import 'package:groupup/modules/onboarding/components/next_button_onboarding.dart';
import 'package:groupup/modules/onboarding/components/onboarding_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingPageViewScreen extends StatefulWidget {
  const OnboardingPageViewScreen({super.key});

  @override
  State<OnboardingPageViewScreen> createState() => _OnboardingPageViewScreenState();
}

class _OnboardingPageViewScreenState extends State<OnboardingPageViewScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.hasData) {
          return GroupsScreen(
            homeViewModel: HomeViewModel(),
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: GPTextHeader(
              text: appLocalizations.generalError,
            ),
          );
        }
        return Scaffold(
          backgroundColor: GPColors.white,
          appBar: const AppBarOnboarding(),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      OnboardingBody(
                        animation: RiveAnimations.createGroup,
                        title: appLocalizations.createOrJoinAGroup,
                        subtitle:
                            appLocalizations.createOrJoinAGroupOnboardingText,
                      ),
                      OnboardingBody(
                        animation: RiveAnimations.addDataAndPhoto,
                        title: appLocalizations.addDataAndPhotoOnboarding,
                        subtitle:
                            appLocalizations.addDataAndPhotoOnboardingText,
                      ),
                      OnboardingBody(
                        animation: RiveAnimations.validateData,
                        title: appLocalizations.validateDataOnboarding,
                        subtitle: appLocalizations.validateDataOnboardingText,
                      ),
                      OnboardingBody(
                        animation: RiveAnimations.winReward,
                        title: appLocalizations.winRewardOnboarding,
                        subtitle: appLocalizations.winRewardOnboardingText,
                      ),
                    ],
                  ),
                ),
                GPPageIndicator(
                  controller: _pageController,
                  count: 4,
                  dotHeight: 12.5,
                  dotWidth: 12.5,
                  dotColor: GPColors.lightGray,
                  activeDotColor: GPColors.primaryColor,
                ),
                SizedBox(
                  height: context.screenHeight * 0.05,
                ),
                GPButtonOnboarding(
                  controller: _pageController,
                ),
                SizedBox(
                  height: context.screenHeight * 0.075,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
