import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';

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
      child: GPTextBody(
        text: text,
        maxLines: 3,
        textAlign: TextAlign.center,
        color: GPColors.secondaryColor,
        minFontSize: (context.screenHeight * 0.0215).roundToDouble(),
        maxFontSize: (context.screenHeight * 0.0215).roundToDouble(),
      ),
    );
  }
}
