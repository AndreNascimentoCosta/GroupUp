import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/design-system.dart';

final themeData = ThemeData(
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  splashColor: GPColors.transparent,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: GPColors.secondaryColor,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Insets.s,
        ),
      ),
      borderSide: BorderSide(
        color: GPColors.secondaryColor,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Insets.s,
        ),
      ),
      borderSide: BorderSide(
        color: GPColors.red,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Insets.s,
        ),
      ),
      borderSide: BorderSide(
        color: GPColors.primaryColor,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          Insets.s,
        ),
      ),
      borderSide: BorderSide(
        color: GPColors.red,
      ),
    ),
  ),
);
