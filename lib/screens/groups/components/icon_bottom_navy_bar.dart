import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/constants/design-system.dart';

class IconBottonNavyBarModel extends StatelessWidget {
  const IconBottonNavyBarModel({required this.imageIcon});

  final String imageIcon;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imageIcon,
      height: Insets.l * 1.5,
      width: Insets.l * 1.5,
    );
  }
}
