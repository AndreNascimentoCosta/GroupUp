import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/styles/text.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    this.onPressed,
    this.text = 'Next',
    this.borderColor = kPrimaryColor,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    this.height = 50,
    this.width = 140,
  });

  final void Function()? onPressed;
  final String text;
  final Color borderColor;
  final Color color;
  final Color textColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: onPressed == null ? kSecondaryColor : borderColor,
        ),
        borderRadius: BorderRadius.circular(Insets.s),
        color: onPressed == null ? kSecondaryColor : color,
      ),
      child: ButtonCommonStyle(
        onPressed: onPressed,
        child: StandardTextStyle(
          text: text,
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody,
          color: textColor,
        ),
      ),
    );
  }
}
