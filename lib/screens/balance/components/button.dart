import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class Button extends StatelessWidget {
  const Button(
      {required this.text, required this.buttonColor, required this.textColor});

  final String text;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () {},
      child: Container(
        alignment: AlignmentDirectional.center,
        height: 35,
        width: 90,
        decoration: BoxDecoration(
          border: Border.all(color: buttonColor),
          borderRadius: BorderRadius.circular(Insets.l),
          color: buttonColor,
        ),
        child: StaticText(
          text: text,
          color: textColor,
          fontSize: TextSize.sBody,
        ),
      ),
    );
  }
}