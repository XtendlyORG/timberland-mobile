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
      case 'easy':
        return Difficulties.easy;
      case 'moderate':
        return Difficulties.moderate;
      case 'hard':
        return Difficulties.hard;
      default:
        throw Exception(
          "Difficulty $name is not valid, append it to 'Difficulties' abstract object",
        );
    }
  }
}

abstract class Difficulties {
  static const DifficultyLevel easy = DifficultyLevel(
    name: 'Easy',
    textColor: TimberlandColor.accentColor,
    backgroundColor: TimberlandColor.lighGreen,
  );
  static const DifficultyLevel moderate = DifficultyLevel(
    name: 'Moderate',
    textColor: TimberlandColor.primary,
    backgroundColor: TimberlandColor.lightBlue,
  );

  static const DifficultyLevel hard = DifficultyLevel(
    name: 'Hard',
    textColor: TimberlandColor.secondaryColor,
    backgroundColor: TimberlandColor.lightRed,
  );
}
