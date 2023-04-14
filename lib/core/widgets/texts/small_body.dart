import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';

class SmallBody extends StatelessWidget {
  const SmallBody({
    required this.text,
    this.fontFamily = 'Montserrat-Medium',
    this.color = GPColors.black,
    this.overflow,
    this. textAlign,
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
      minFontSize: 12,
      maxFontSize: 14,
      style: TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
