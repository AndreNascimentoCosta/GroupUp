import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class LargeBody extends StatelessWidget {
  const LargeBody({
    required this.text,
    this.fontFamily = 'Montserrat-Medium',
    this.color = GPColors.black,
    this.overflow,
    this.textAlign,
    this.maxLines = 1,
    this.letterSpacing,
  });

  final String text;
  final String fontFamily;
  final Color color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int maxLines;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      minFontSize: 16,
      maxFontSize: 18,
      style: TextStyle(
        letterSpacing: letterSpacing,
        fontSize: 18,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
