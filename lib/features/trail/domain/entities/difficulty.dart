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
  factory DifficultyLevel.fromInt(int difficultyLevel) {
    switch (difficultyLevel) {
      case 1:
        return Difficulties.easiest;
      case 2:
        return Difficulties.easy;
      case 3:
        return Difficulties.intermediate;
      case 4:
        return Difficulties.advance;
      case 5:
        return Difficulties.expert;
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
    intermediate,
    advance,
    expert,
  ];

  static const DifficultyLevel easiest = DifficultyLevel(
    id: 1,
    name: 'Easiest',
    primaryColor: TimberlandColor.accentColor,
    secondaryColor: TimberlandColor.background,
  );

  static const DifficultyLevel easy = DifficultyLevel(
    id: 2,
    name: 'Easy',
    primaryColor: TimberlandColor.accentColor,
    secondaryColor: TimberlandColor.background,
  );

  static const DifficultyLevel intermediate = DifficultyLevel(
    id: 3,
    name: 'Intermediate',
    primaryColor: TimberlandColor.primary,
    secondaryColor: TimberlandColor.lightBlue,
  );

  static const DifficultyLevel advance = DifficultyLevel(
    id: 4,
    name: 'Advance',
    primaryColor: Color(0xff34459b),
    secondaryColor: TimberlandColor.background,
  );

  static const DifficultyLevel expert = DifficultyLevel(
    id: 5,
    name: 'Expert',
    primaryColor: TimberlandColor.text,
    secondaryColor: TimberlandColor.background,
  );
}
