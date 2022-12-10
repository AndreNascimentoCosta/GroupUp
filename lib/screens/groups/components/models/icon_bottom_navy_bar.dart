import 'package:flutter/material.dart';

class IconBottonNavyBarModel extends StatelessWidget {
  IconBottonNavyBarModel({required this.imageIcon});

  String imageIcon;

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
