import 'package:flutter/material.dart';

extension GPSizeExtension on BuildContext {

  Size get screenSize => MediaQuery.of(this).size;


  EdgeInsets get screenViewInsets => MediaQuery.of(this).viewInsets;


  EdgeInsets get screenViewPadding => MediaQuery.of(this).viewPadding;


  double get screenWidth => MediaQuery.of(this).size.width;


  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isSmallScreen => screenHeight < 800 || screenWidth < 350;

  bool get isVerySmallScreen => screenHeight < 600 || screenWidth < 350;

  bool get isAndroidScreen => screenHeight > 820 && screenHeight < 821 && screenWidth < 412;

  bool get isScreenSize0 => screenHeight < 620 && screenWidth < 350;

  bool get isScreenSize1 => screenHeight > 650 && screenHeight < 680 && screenWidth > 350 && screenWidth < 380;

  bool get isScreenSize2 => screenHeight > 820 && screenHeight < 830 && screenWidth > 385 && screenWidth < 395;

  bool get isScreenSize3 => screenHeight > 835 && screenHeight < 845 && screenWidth > 405 && screenWidth < 415;

  bool get isScreenSize4 => screenHeight > 800 && screenHeight < 810 && screenWidth > 380 && screenWidth < 400;

  bool get isScreenSize5 => screenHeight > 770 && screenHeight < 790 && screenWidth > 380 && screenWidth < 400;

}
