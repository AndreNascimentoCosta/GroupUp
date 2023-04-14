import 'package:flutter/material.dart';

/// Extending the BuildContext class with the FBSizeExtension class.
extension GPSizeExtension on BuildContext {
  /// A getter function that returns the size of the screen.
  Size get screenSize => MediaQuery.of(this).size;

  /// Getting the view insets of the screen.
  EdgeInsets get screenViewInsets => MediaQuery.of(this).viewInsets;

  /// Getting the view padding of the screen.
  EdgeInsets get screenViewPadding => MediaQuery.of(this).viewPadding;

  /// A getter function that returns the width of the screen.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// A getter function that returns the height of the screen.
  double get screenHeight => MediaQuery.of(this).size.height;
}
