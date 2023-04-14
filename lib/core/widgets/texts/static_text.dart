import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class StaticText extends StatelessWidget {
  const StaticText({
    required this.text,
    this.textAlign,
    this.overflow,
    this.letterSpacing,
    this.fontFamily = 'Montserrat-Medium',
    this.fontSize = 12,
    this.fontWeight,
    this.color = GPColors.black,
    this.maxLines = 1,
  });

  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final String fontFamily;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color color;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
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
