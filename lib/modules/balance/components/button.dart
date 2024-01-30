import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';

class Button extends StatelessWidget {
  const Button({
    required this.text,
    required this.buttonColor,
    required this.textColor,
    this.onPressed,
  });

  final String text;
  final Color buttonColor;
  final Color textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Container(
        alignment: AlignmentDirectional.center,
        height: context.screenHeight * 0.05,
        width: context.screenWidth * 0.275,
        decoration: BoxDecoration(
          border: Border.all(color: buttonColor),
          borderRadius: BorderRadius.circular(Insets.l),
          color: buttonColor,
        ),
        child: GPTextBody(
          text: text,
          color: textColor,
        ),
      ),
    );
  }
}
