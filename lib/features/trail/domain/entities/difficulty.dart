// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class DifficultyLevel {
  final int id;
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  const DifficultyLevel({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
  });

  factory DifficultyLevel.fromString(String name) {
    switch (name.toLowerCase()) {
      case 'easiest':
        return Difficulties.easy;
      case 'easy':
        return Difficulties.easy;
      case 'more difficult':
        return Difficulties.moreDifficult;
      case 'very difficult':
        return Difficulties.veryDifficult;
      default:
        throw Exception(
          "Difficulty $name is not valid, append it to 'Difficulties' abstract object",
        );
    }
  }
  factory DifficultyLevel.fromInt(int difficultyLevel) {
    switch (difficultyLevel) {
      case 1:
        return Difficulties.easiest;
      case 2:
        return Difficulties.easy;
      // case 3:
      //   return Difficulties.intermediate;
      case 3:
        return Difficulties.moreDifficult;
      case 4:
        return Difficulties.veryDifficult;
      default:
        throw Exception(
          "Difficulty $difficultyLevel is not valid, append it to 'Difficulties' abstract object",
        );
    }
  }
}

abstract class Difficulties {
  static List<DifficultyLevel> all = [
    easiest,
    easy,
    // intermediate,
    moreDifficult,
    veryDifficult,
  ];

  static const DifficultyLevel easiest = DifficultyLevel(
    id: 1,
    name: 'Easiest',
    primaryColor: TimberlandColor.background,
    secondaryColor: TimberlandColor.accentColor,
  );

  static const DifficultyLevel easy = DifficultyLevel(
    id: 2,
    name: 'Easy',
    primaryColor: TimberlandColor.accentColor,
    secondaryColor: TimberlandColor.background,
  );

  static const DifficultyLevel moreDifficult = DifficultyLevel(
    id: 3,
    name: 'More Difficult',
    primaryColor: Color(0xff34459b),
    secondaryColor: TimberlandColor.background,
  );

  static const DifficultyLevel veryDifficult = DifficultyLevel(
    id: 4,
    name: 'Very Difficult',
    primaryColor: TimberlandColor.text,
    secondaryColor: TimberlandColor.background,
  );
}
