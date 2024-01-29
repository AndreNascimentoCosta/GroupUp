import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';

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
      child: GPTextBody(
        text: text,
        color: color,
        fontSize: 16,
      ),
    );
  }
}
