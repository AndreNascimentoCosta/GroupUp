import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

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
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.230,
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
