import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// A widget that displays an svg icon
class GPIcon extends StatelessWidget {
  /// This is a constructor.
  const GPIcon(
    this.icon, {
    this.height,
    this.width,
    this.fit,
    this.color,
    super.key,
  });

  /// A variable that is being passed in from the constructor.
  final String icon;

  /// A variable that is being passed in from the constructor.
  final double? height;

  /// A variable that is being passed in from the constructor.
  final double? width;

  /// A nullable type.
  final BoxFit? fit;

  /// A nullable type.
  final Color? color;
  @override
  Widget build(BuildContext context) {
    if (icon.contains('svg')) {
      return SvgPicture.asset(
        icon,
        height: height,
        width: width,
        fit: fit ?? BoxFit.contain,
        color: color,
      );
    }
    return Image.asset(
      icon,
      height: height,
      width: width,
      fit: fit ?? BoxFit.contain,
      color: color,
    );
  }
}
