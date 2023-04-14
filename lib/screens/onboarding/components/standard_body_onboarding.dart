import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/screens/onboarding/components/animation_box_onboarding.dart';
import 'package:groupup/screens/onboarding/components/subtitle_onboarding.dart';
import 'package:groupup/screens/onboarding/components/title_onboarding.dart';

class StandardOnboardingBody extends StatelessWidget {
  const StandardOnboardingBody({
    required this.animation,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String animation;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimationBox(
          animation: animation,
        ),
        SizedBox(
          height: context.screenHeight * 0.025,
        ),
        OnboardingTitle(
          text: title,
        ),
        SizedBox(
          height: context.screenHeight * 0.025,
        ),
        OnboardingSubtitle(
          text: subtitle,
        ),
      ],
    );
  }
}
