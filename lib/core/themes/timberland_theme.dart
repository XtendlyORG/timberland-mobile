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
            fixedSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
        bannerTheme: const MaterialBannerThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0.01,
          contentTextStyle: TextStyle(
            color: TimberlandColor.background,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: TimberlandColor.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          isDense: true,
          isCollapsed: true,
          fillColor: TimberlandColor.background,
          // filled: true,
          errorMaxLines: 2,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: TimberlandColor.primary),
            borderRadius: BorderRadius.circular(6),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          alignLabelWithHint: true,
          hintStyle: const TextStyle(fontSize: 18),
        ),
        scaffoldBackgroundColor: TimberlandColor.background,
        textTheme: TextTheme(
          titleSmall: const TextStyle(
            color: TimberlandColor.text,
            fontSize: 16,
          ),
          titleMedium: const TextStyle(
            color: TimberlandColor.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: const TextStyle(
            color: TimberlandColor.text,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            color: TimberlandColor.text,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.barlow().fontFamily,
          ),
          // bodyText1: TextStyle()
        ),
        listTileTheme: const ListTileThemeData(
          minLeadingWidth: 20,
          textColor: TimberlandColor.background,
          iconColor: TimberlandColor.background,
        ),
      );
}
