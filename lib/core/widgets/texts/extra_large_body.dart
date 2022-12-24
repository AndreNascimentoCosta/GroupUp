import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ExtraLargeBody extends StatelessWidget {
  const ExtraLargeBody({
    required this.text,
    this.fontFamily = 'Montserrat-Medium',
    this.color = Colors.black,
    this.overflow,
    this.textAlign,
    this.maxLines = 1,
  });

  final String text;
  final String fontFamily;
  final Color color;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      minFontSize: 18,
      maxFontSize: 20,
      style: TextStyle(
        fontSize: 20,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
