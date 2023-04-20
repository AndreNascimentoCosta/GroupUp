import 'package:flutter/material.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/constants/design-system.dart';

BoxDecoration boxDecoration() {
  return BoxDecoration(
    border: Border.all(color: GPColors.primaryColor),
    borderRadius: BorderRadius.circular(Insets.xs),
    color: GPColors.primaryColor,
    boxShadow: const [
      BoxShadow(
        color: GPColors.secondaryColor,
        spreadRadius: 1,
        blurRadius: 2,
      ),
    ],
  );
}
