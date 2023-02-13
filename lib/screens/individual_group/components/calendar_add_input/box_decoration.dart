import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';

BoxDecoration boxDecoration() {
  return BoxDecoration(
    border: Border.all(color: kPrimaryColor),
    borderRadius: BorderRadius.circular(Insets.xs),
    color: kPrimaryColor,
    boxShadow: const [
      BoxShadow(
        color: kSecondaryColor,
        spreadRadius: 1,
        blurRadius: 2,
      ),
    ],
  );
}
