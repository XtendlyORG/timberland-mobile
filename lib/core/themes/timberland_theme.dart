import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'timberland_color.dart';

class TimberlandTheme {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: TimberlandColor.primary,
        primaryColor: TimberlandColor.primary,
        backgroundColor: TimberlandColor.background,
        fontFamily: GoogleFonts.openSans().fontFamily,
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
          fillColor: TimberlandColor.background,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: TimberlandColor.primary),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        scaffoldBackgroundColor: TimberlandColor.background,
        textTheme: TextTheme(
          titleSmall: const TextStyle(
            color: TimberlandColor.text,
            fontSize: 14,
          ),
          headlineSmall: TextStyle(
            color: TimberlandColor.text,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.barlow().fontFamily,
          ),
        ),
        listTileTheme: const ListTileThemeData(
          minLeadingWidth: 20,
          textColor: TimberlandColor.background,
          iconColor: TimberlandColor.background,
        ),
      );
}
