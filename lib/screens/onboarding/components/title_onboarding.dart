import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return StaticText(
      text: text,
      maxLines: 2,
      textAlign: TextAlign.center,
      fontSize: context.screenHeight * 0.0285,
      fontFamily: 'MontSerrat-Bold',
    );
  }
}
