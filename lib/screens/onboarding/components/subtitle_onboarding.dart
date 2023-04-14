import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';

class OnboardingSubtitle extends StatelessWidget {
  const OnboardingSubtitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: StaticText(
        text: text,
        fontSize: context.screenHeight * 0.0215,
        maxLines: 3,
        textAlign: TextAlign.center,
        color: GPColors.secondaryColor,
      ),
    );
  }
}
