import 'package:flutter/material.dart';

enum ThemeStyle {
  light,
  dark,
}

class AppColors {
  AppColors._();

  static const MaterialColor kPrimaryColor = MaterialColor(
    0xFF2196F3,
    <int, Color>{
      50: Color(0x88FFC7FF),
      100: Color(0xFFFFC7FF),
      200: Color(0xFFF1A6AA),
      300: Color(0xFFFF99E0),
      400: Color(0xFFFF6DA3),
      500: Color(0xFFEE4463),
      600: Color(0xFFEE4463),
      700: Color(0xFFEE4463),
      800: Color(0xFFEE4463),
      900: Color(0xFF895E6B),
    },
  );
  static const MaterialColor kSecondaryColor = MaterialColor(
    0xFF2196F3,
    <int, Color>{
      50: Color(0x88FFC7FF),
      100: Color(0xFFFFC7FF),
      200: Color(0xFFF1A6AA),
      300: Color(0xFFFF99E0),
      400: Color(0xFFFF6DA3),
      500: Color(0xFFEE4463),
      600: Color(0xFFEE4463),
      700: Color(0xFFEE4463),
      800: Color(0xFFEE4463),
      900: Color(0xFF895E6B),
    },
  );

  static const Color transparent = Color(0x00000000);

  static const Color white = Color(0xFFFFFFFF);

  static const Color black = Color(0xFF000000);

  static const Color black54 = Color(0x8A000000);

  static const Color blue = Color(0xFF2196F3);

  static const Color green = Color(0xFF43A838);

  static const Color red = Color(0xFFFF3B3B);

  static const Color gray = Color(0xFFAAAAAA);

  static const Color lightGray = Color(0xFF909296);

  static const Color colorDivider = Color(0xFFEBEBEB);

  static const Color svgTintColor = Color(0x29000000);

  static const Color neutral6 = Color.fromRGBO(0, 0, 0, 0.04);

  static const Color neutral3 = Color(0xFFADAFC5);

  static const Color textFiledBg = Color(0xFFDADADA);

  static const Color textFiledHintColor = Color(0xFF4D4D4D);

  static const Color emptyProgressColor = Color(0xB2ECECEC);

  static const Color progressBgColor = Color(0x33000000);
}