import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/styles/standard_text.dart';

class BodyButtonModel extends StatelessWidget {
  BodyButtonModel({required this.text, required this.secondaryText, required this.onPressed});

  String text;
  String secondaryText;
  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      child: Row(
                children: [
                  StandardTextStyle(text: text, fontSize: 18),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: StandardTextStyle(text: secondaryText, fontSize: 18),
                  ),
                  const ImageIcon(
                    AssetImage(
                      'assets/icons/arrow_right.png',
                    ),
                    size: kDefaultPadding,
                    color: Color(0xFFC3C3C3),
                  ),
                ],
              ),
    );
  }
}
