import 'package:flutter/material.dart';

class AppColor {
  //https://dribbble.com/shots?color=D9DCFA
  static const primaryColor = Color(0xfff0f3ff);
  static const backgroundColor = Color(0xffeeeefe);
  static const cardColor = Color(0xfff2f5ff);
  static const shadowColor = Color(0xff3d36ca);
  static const shadowColor2 = Color(0xff250ba2);

  static const MaterialColor primarySwatch =
      MaterialColor(_primarySwatchPrimaryValue, <int, Color>{
    50: Color(0xFFE1E1E1),
    100: Color(0xFFB3B3B3),
    200: Color(0xFF818181),
    300: Color(0xFF4F4F4F),
    400: Color(0xFF292929),
    500: Color(_primarySwatchPrimaryValue),
    600: Color(0xFF030303),
    700: Color(0xFF020202),
    800: Color(0xFF020202),
    900: Color(0xFF010101),
  });
  static const int _primarySwatchPrimaryValue = 0xFF030303;

  static const MaterialColor primarySwatchAccent =
      MaterialColor(_primarySwatchAccentValue, <int, Color>{
    100: Color(0xFFA6A6A6),
    200: Color(_primarySwatchAccentValue),
    400: Color(0xFF737373),
    700: Color(0xFF666666),
  });
  static const int _primarySwatchAccentValue = 0xFF8C8C8C;
}
