import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class MediumBody extends StatelessWidget {
  const MediumBody({
    required this.text,
    this.fontFamily = 'Montserrat-Medium',
    this.color = GPColors.black,
    this.overflow,
    this.textAlign,
  });

  final String text;
  final String fontFamily;
  final Color color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
      overflow: overflow,
      textAlign: textAlign,
      minFontSize: 14,
      maxFontSize: 16,
      style: TextStyle(
        fontSize: 16,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
