import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';

class OtherOptions extends StatelessWidget {
  const OtherOptions({
    required this.onPressed,
    required this.text,
    this.color = GPColors.black,
  });

  final void Function() onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: GUTextBody(
        text: text,
        color: color,
        minFontSize: 16,
        maxFontSize: 18,
      ),
    );
  }
}
