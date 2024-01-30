import 'package:flutter/material.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';

TextStyle bottomCalendarTextStyle(BuildContext context) {
  final screenHeight = context.screenHeight;
  final screenWidth = context.screenWidth;
  final isVerySmallScreen = screenHeight < 600 || screenWidth < 300;
  return TextStyle(
    fontFamily: 'Montserrat-Medium',
    fontSize: isVerySmallScreen ? 14 : 16,
    color: const Color(0xFF7A7A7A),
  );
}
