import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class GUTextHeader extends StatelessWidget {
  const GUTextHeader({
    required this.text,
    this.fontFamily = 'Montserrat-SemiBold',
    this.color = GPColors.black,
    this.overflow,
    this.textAlign,
    this.maxLines = 1,
    this.minFontSize = 20,
    this.maxFontSize = 24,
  });

  final String text;
  final String fontFamily;
  final Color color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int maxLines;
  final double minFontSize;
  final double maxFontSize;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      style: TextStyle(
        fontSize: 24,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
