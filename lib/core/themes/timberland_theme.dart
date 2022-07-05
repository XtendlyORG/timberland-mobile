import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class TimberlandTheme {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: TimberlandColor.primary,
        primaryColor: TimberlandColor.primary,
        backgroundColor: TimberlandColor.background,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: TimberlandColor.primary,
            primary: TimberlandColor.background,
            fixedSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: TimberlandColor.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: TimberlandColor.primary),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(
            color: TimberlandColor.text,
            fontSize: 14,
          ),
        ),
      );
}
