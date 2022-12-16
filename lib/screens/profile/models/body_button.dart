import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class BodyButtonModel extends StatelessWidget {
  const BodyButtonModel(
      {required this.text,
      required this.secondaryText,
      required this.onPressed});

  final String text;
  final String secondaryText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Row(
        children: [
          StandardTextStyle(text: text, fontSize: TextSize.lBody),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: kDefaultPadding),
            child: Text(
              secondaryText,
              style: const TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: TextSize.lBody,
                color: Colors.black,
              ),
            ),
            // StandardTextStyle(text: secondaryText, fontSize: 18),
          ),
          const ImageIcon(
            AssetImage(
              'assets/icons/arrow_right.png',
            ),
            size: kDefaultPadding,
            color: kSecondaryColor,
          ),
        ],
      ),
    );
  }
}
