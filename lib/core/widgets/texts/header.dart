import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    required this.text,
    this.fontFamily = 'Montserrat-Bold',
    this.color = Colors.black,
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
      minFontSize: 20,
      maxFontSize: 24,
      style: TextStyle(
        fontSize: 24,
        fontFamily: fontFamily,
        color: color,
      ),
    );
  }
}
