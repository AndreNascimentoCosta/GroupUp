import 'package:flutter/material.dart';

class StandardTextStyle extends StatelessWidget {
  StandardTextStyle({
    required this.text,
    this.textAlign,
    this.overflow,
    this.letterSpacing,
    this.fontFamily = 'Montserrat-Medium',
    this.fontSize = 12,
    this.fontWeight,
    this.color = Colors.black,
  });

  String text;
  TextAlign? textAlign;
  TextOverflow? overflow;
  double? letterSpacing;
  String fontFamily;
  double fontSize;
  FontWeight? fontWeight;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      Characters(text).replaceAll(Characters(''), Characters('\u{200B}')).toString(),
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        letterSpacing: letterSpacing,
        fontFamily: fontFamily,
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
