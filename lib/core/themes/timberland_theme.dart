import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class TimberlandTheme {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: TimberlandColor.test,
        primaryColor: TimberlandColor.test,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: TimberlandColor.test.shade300,
            primary: TimberlandColor.test.shade50,
          ),
        ),
      );
}
