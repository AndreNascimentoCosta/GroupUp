import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

BoxDecoration boxDecoration() {
  return BoxDecoration(
      border: Border.all(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(5),
      color: kPrimaryColor,
      boxShadow: const [
        BoxShadow(
          color: kSecondaryColor,
          spreadRadius: 1,
          blurRadius: 2,
        ),
      ]);
}
