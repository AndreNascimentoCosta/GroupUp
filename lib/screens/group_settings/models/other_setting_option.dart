import 'package:flutter/material.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class OtherSettingOption extends StatelessWidget {
  const OtherSettingOption(
      {required this.onPressed, required this.text, this.color = Colors.black});

  final void Function() onPressed;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: onPressed,
      color: color,
      child: StandardTextStyle(text: text, color: color, fontSize: 18),
    );
  }
}
