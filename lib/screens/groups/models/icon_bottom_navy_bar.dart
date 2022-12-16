import 'package:flutter/material.dart';

class IconBottonNavyBarModel extends StatelessWidget {
  const IconBottonNavyBarModel({required this.imageIcon});

  final String imageIcon;

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(
        imageIcon,
      ),
      size: 30,
    );
  }
}
