import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/screens/profile/styles/text_body_button.dart';

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
                  Text(
                    text,
                    style: textStyleBodyButton()
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    child: Text(
                      secondaryText,
                      style: textStyleBodyButton()
                    ),
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
