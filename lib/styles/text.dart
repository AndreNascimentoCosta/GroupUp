import 'package:flutter/material.dart';

class StandardTextStyle extends StatelessWidget {
  const StandardTextStyle({
    required this.text,
    this.textAlign,
    this.overflow,
    this.letterSpacing,
    this.fontFamily = 'Montserrat-Medium',
    this.fontSize = 12,
    this.fontWeight,
    this.color = Colors.black,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final String fontFamily;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
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
