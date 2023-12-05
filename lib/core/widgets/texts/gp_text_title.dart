import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class GPTextTitle extends StatelessWidget {
  const GPTextTitle({
    required this.text,
    this.fontFamily = 'Montserrat-Bold',
    this.color = GPColors.black,
    this.maxLines = 1,
    this.overflow,
    this.textAlign,
  });

  final String text;
  final String fontFamily;
  final Color color;
  final int maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      minFontSize: 25,
      maxFontSize: 30,
      style: TextStyle(
        fontSize: 30,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}