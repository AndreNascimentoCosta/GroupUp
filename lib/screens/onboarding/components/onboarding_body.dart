import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:rive/rive.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
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
        SizedBox(
          height: context.screenHeight * 0.475,
          width: context.screenHeight * 0.475,
          child: RiveAnimation.asset(
            animation,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: context.screenHeight * 0.025,
        ),
        GPTextHeader(
          text: title,
          maxLines: 2,
          textAlign: TextAlign.center,
          fontFamily: 'MontSerrat-Bold',
          minFontSize: (context.screenHeight * 0.0285).roundToDouble(),
          maxFontSize: (context.screenHeight * 0.0285).roundToDouble(),
        ),
        SizedBox(
          height: context.screenHeight * 0.025,
        ),
        SizedBox(
          width: 300,
          child: GPTextBody(
            text: subtitle,
            maxLines: 3,
            textAlign: TextAlign.center,
            color: GPColors.secondaryColor,
            minFontSize: (context.screenHeight * 0.0215).roundToDouble(),
            maxFontSize: (context.screenHeight * 0.0215).roundToDouble(),
          ),
        ),
      ],
    );
  }
}
