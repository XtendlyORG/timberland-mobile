// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class DifficultyLevel {
  final String name;
  final Color textColor;
  final Color backgroundColor;
  const DifficultyLevel({
    required this.name,
    required this.textColor,
    required this.backgroundColor,
  });

  factory DifficultyLevel.fromString(String name) {
    switch (name.toLowerCase()) {
      case 'easiest':
        return Difficulties.easy;
      case 'easy':
        return Difficulties.easy;
      case 'intermediate':
        return Difficulties.intermediate;
      case 'advance':
        return Difficulties.advance;
      case 'expert':
        return Difficulties.expert;
      default:
        throw Exception(
          "Difficulty $name is not valid, append it to 'Difficulties' abstract object",
        );
    }
  }
}

abstract class Difficulties {
  static List<DifficultyLevel> all = [
    easy,
  ];

  static const DifficultyLevel easiest = DifficultyLevel(
    name: 'Easiest',
    textColor: TimberlandColor.accentColor,
    backgroundColor: TimberlandColor.lighGreen,
  );

  static const DifficultyLevel easy = DifficultyLevel(
    name: 'Easy',
    textColor: TimberlandColor.accentColor,
    backgroundColor: TimberlandColor.lighGreen,
  );

  static const DifficultyLevel intermediate = DifficultyLevel(
    name: 'Intermediate',
    textColor: TimberlandColor.primary,
    backgroundColor: TimberlandColor.lightBlue,
  );

  static const DifficultyLevel advance = DifficultyLevel(
    name: 'Advance',
    textColor: TimberlandColor.secondaryColor,
    backgroundColor: TimberlandColor.lightRed,
  );

  static const DifficultyLevel expert = DifficultyLevel(
    name: 'Expert',
    textColor: TimberlandColor.background,
    backgroundColor: TimberlandColor.text,
  );
}
