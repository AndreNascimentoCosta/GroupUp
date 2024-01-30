import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';

TextStyle bottomCalendarTextStyle(BuildContext context) {
  final isVerySmallScreen = context.screenHeight < 600 || context.screenWidth < 300;
  return TextStyle(
    fontFamily: 'Montserrat-Medium',
    fontSize: isVerySmallScreen ? 14 : 16,
    color: const Color(0xFF7A7A7A),
  );
}
