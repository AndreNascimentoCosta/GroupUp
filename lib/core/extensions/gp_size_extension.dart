import 'package:flutter/material.dart';

extension GPSizeExtension on BuildContext {

  Size get screenSize => MediaQuery.of(this).size;


  EdgeInsets get screenViewInsets => MediaQuery.of(this).viewInsets;


  EdgeInsets get screenViewPadding => MediaQuery.of(this).viewPadding;


  double get screenWidth => MediaQuery.of(this).size.width;


  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isSmallScreen => screenHeight < 800 || screenWidth < 350;

  bool get isVerySmallScreen => screenHeight < 600 || screenWidth < 350;
}
