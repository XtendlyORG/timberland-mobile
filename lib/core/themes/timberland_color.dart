import 'package:flutter/material.dart';

abstract class TimberlandColor {
  static const int _primary = 0xff00698F;
  static const MaterialColor primary = MaterialColor(_primary, <int, Color>{
    50: Color(0xFFE0EDF2),
    100: Color(0xFFB3D2DD),
    200: Color(0xFF80B4C7),
    300: Color(0xFF4D96B1),
    400: Color(0xFF2680A0),
    500: Color(_primary),
    600: Color(0xFF006187),
    700: Color(0xFF00567C),
    800: Color(0xFF004C72),
    900: Color(0xFF003B60),
  });

  static const background = Color(0xffF2F2F2);
  static const text = Color(0xff333333);
  static const subtext = Color(0xff4E4B4B);

  static const secondaryColor = Color(0xffF60505);
  static const lightRed = Color(0xffDF544B);
  static const accentColor = Color(0xff374905);
  static const lighGreen = Color(0xffA6CE39);
  static const lightBlue = Color(0xffADD8E6);
}
