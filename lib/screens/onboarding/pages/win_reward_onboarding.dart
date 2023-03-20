import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:rive/rive.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WinRewardOnboarding extends StatelessWidget {
  const WinRewardOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.475,
            width: MediaQuery.of(context).size.height * 0.475,
            child: const RiveAnimation.asset(
              'assets/animations/win_reward_onboarding.riv',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          StaticText(
            text: appLocalizations.winRewardOnboarding,
            maxLines: 2,
            textAlign: TextAlign.center,
            fontSize: MediaQuery.of(context).size.height * 0.0285,
            fontFamily: 'MontSerrat-Bold',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          SizedBox(
            width: 300,
            child: StaticText(
              text:
                  appLocalizations.winRewardOnboardingText,
              fontSize: MediaQuery.of(context).size.height * 0.0215,
              maxLines: 5,
              textAlign: TextAlign.center,
              color: kSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}