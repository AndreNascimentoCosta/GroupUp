import 'package:flutter/material.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/styles/standard_text.dart';

class OtherSettingOption extends StatelessWidget {
  OtherSettingOption(
      {required this.onPressed, required this.text, this.color = Colors.black});

  void Function() onPressed;
  String text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      color: color,
      child: StandardTextStyle(text: text, fontSize: 18,)
    );
  }
}
