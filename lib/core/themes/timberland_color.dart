import 'package:flutter/material.dart';

abstract class TimberlandColor {
  static const MaterialColor test =
      MaterialColor(_testPrimaryValue, <int, Color>{
    50: Color(0xFFE7EFE4),
    100: Color(0xFFC3D6BB),
    200: Color(0xFF9CBB8E),
    300: Color(0xFF749F61),
    400: Color(0xFF568B3F),
    500: Color(_testPrimaryValue),
    600: Color(0xFF326E1A),
    700: Color(0xFF2B6315),
    800: Color(0xFF245911),
    900: Color(0xFF17460A),
  });
  static const int _testPrimaryValue = 0xFF38761D;

  static const MaterialColor testAccent =
      MaterialColor(_testAccentValue, <int, Color>{
    100: Color(0xFF94FF7D),
    200: Color(_testAccentValue),
    400: Color(0xFF40FF17),
    700: Color(0xFF2DFC00),
  });
  static const int _testAccentValue = 0xFF6AFF4A;
}
