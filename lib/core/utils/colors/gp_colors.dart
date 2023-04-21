import 'package:flutter/material.dart';

///It's class has the app's color palette
class GPColors {
  const GPColors._();

  /// It's a static constant variable of type Color gray.
  static const lightGray = Color(0xFFD9D9D9);

  /// It's a static constant variable of type Color black.
  static const black = Color(0xFF000000);

  /// It's a static constant variable of type Color white.
  static const white = Color(0xFFFFFFFF);

  /// It's a static constant variable of type Color red.
  static const red = Color(0xFFFF4D4F);

  /// It's a static constant variable of type Color green.
  static const green = Colors.green;

  /// It's a static constant variable of type Color transparent.
  static const transparent = Colors.transparent;

  /// It's a static constant variable of type Color, the app's primary color.
  static const primaryColor = Color(0xFF46E297);

  /// It's a static constant variable of type Color, the app's secondary color.
  static const secondaryColor = Color(0xCC797979);

  /// It's a static constant variable of type Color, the app's group edit color.
  static const groupEditColor = Color(0xFFC3C3C3);

  /// It's a static constant variable of type Color, the app's error color.
  static const error = Color(0xFFFF4D4F);

  /// It's a static constant variable of type Color black with opacity.
  static final shadow = GPColors.black.withOpacity(0.1);
}
