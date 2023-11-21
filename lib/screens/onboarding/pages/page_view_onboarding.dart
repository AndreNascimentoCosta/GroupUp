import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/screens/onboarding/components/app_bar_onboarding.dart';
import 'package:groupup/screens/onboarding/components/next_button_onboarding.dart';
import 'package:groupup/screens/onboarding/pages/add_data_and_photo_onboarding.dart';
import 'package:groupup/screens/onboarding/pages/create_group_onboarding.dart';
import 'package:groupup/screens/onboarding/pages/validate_data_onboarding.dart';
import 'package:groupup/screens/onboarding/pages/win_reward_onboarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PageViewOnboarding extends StatefulWidget {
  const PageViewOnboarding({super.key});

  @override
  State<PageViewOnboarding> createState() => _PageViewOnboardingState();
}

class _PageViewOnboardingState extends State<PageViewOnboarding> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
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
            child: Header(
              text: AppLocalizations.of(context)!.generalError,
            ),
          );
        }
        return Scaffold(
          backgroundColor: GPColors.white,
          appBar: const AppBarOnboarding(),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: const [
                    CreateGroupOnboarding(),
                    AddDataAndPhotoOnboarding(),
                    ValidateDataOnboarding(),
                    WinRewardOnboarding(),
                  ],
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 4,
                effect: const WormEffect(
                  dotHeight: 12.5,
                  dotWidth: 12.5,
                  dotColor: GPColors.lightGray,
                  activeDotColor: GPColors.primaryColor,
                  type: WormType.thin,
                ),
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
        );
      },
    );
  }
}
