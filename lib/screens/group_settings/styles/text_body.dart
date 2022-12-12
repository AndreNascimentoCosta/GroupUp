import 'package:flutter/material.dart';

class TextBodySettings extends StatelessWidget {
  TextBodySettings({required this.text, this.textAlign, this.color = Colors.black});

  String text;
  TextAlign? textAlign;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Montserrat-Medium',
        fontSize: 18,
        color: color,
      ),
    );
  }
}
