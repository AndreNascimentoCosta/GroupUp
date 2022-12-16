import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class NextButton extends StatelessWidget {
  const NextButton({required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 140,
      decoration: BoxDecoration(
        border: Border.all(color: kPrimaryColor),
        borderRadius: BorderRadius.circular(Insets.s),
        color: kPrimaryColor,
      ),
      child: ButtonCommonStyle(
        onPressed: onPressed,
        child: const StandardTextStyle(
          text: 'Next',
          fontFamily: 'Montserrat-SemiBold',
          fontSize: TextSize.lBody,
          color: Colors.white,
        ),
      ),
    );
  }
}
