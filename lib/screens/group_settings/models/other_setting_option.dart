import 'package:flutter/material.dart';
import 'package:groupup/screens/group_settings/styles/text_body.dart';
import 'package:groupup/styles/button_style.dart';

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
      child: TextBodySettings(text: text, color: color,),
    );
  }
}
