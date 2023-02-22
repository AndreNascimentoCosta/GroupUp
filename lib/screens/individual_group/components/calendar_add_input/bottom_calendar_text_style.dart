import 'package:flutter/material.dart';

TextStyle bottomCalendarTextStyle(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;
  final isVerySmallScreen = screenHeight < 600 || screenWidth < 300;
  return TextStyle(
    fontFamily: 'Montserrat-Medium',
    fontSize: isVerySmallScreen ? 14 : 16,
    color: const Color(0xFF7A7A7A),
  );
}
