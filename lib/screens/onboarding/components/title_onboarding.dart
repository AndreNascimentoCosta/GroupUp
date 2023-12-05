import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return GPTextHeader(
      text: text,
      maxLines: 2,
      textAlign: TextAlign.center,
      fontFamily: 'MontSerrat-Bold',
      minFontSize: (context.screenHeight * 0.0285).roundToDouble(),
      maxFontSize: (context.screenHeight * 0.0285).roundToDouble(),
    );
  }
}
