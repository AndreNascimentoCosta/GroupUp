import 'package:flutter/material.dart';

class StandardEllipsisTextStyle extends StatelessWidget {
  const StandardEllipsisTextStyle({
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
