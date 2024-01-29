import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class GPTextHeader extends StatelessWidget {
  const GPTextHeader({
    required this.text,
    this.fontFamily = 'Montserrat-SemiBold',
    this.color = GPColors.black,
    this.overflow,
    this.textAlign,
    this.maxLines = 1,
    this.fontSize = 20,
  });

  final String text;
  final String fontFamily;
  final Color color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int maxLines;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
