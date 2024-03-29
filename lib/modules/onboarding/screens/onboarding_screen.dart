import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/animations/rive_animations.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/loading/gp_loading.dart';
import 'package:groupup/core/widgets/page_indicator/gp_page_indicator.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/models/home_view_model.dart';
import 'package:groupup/modules/main_page_view/screens/main_page_view_screen.dart';
import 'package:groupup/modules/onboarding/components/onboarding_app_bar.dart';
import 'package:groupup/modules/onboarding/components/onboarding_next_button.dart';
import 'package:groupup/modules/onboarding/components/onboarding_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const GPLoading();
        }
        if (snapshot.hasData) {
          return MainPageViewScreen(
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
          appBar: const OnboardingAppBar(),
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
                OnboardingNextButton(
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
