// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class DifficultyLevel {
  final String name;
  final Color difficultyColor;
  const DifficultyLevel({
    required this.name,
    required this.difficultyColor,
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
      name: 'Easy', difficultyColor: TimberlandColor.accentColor);
  static const DifficultyLevel moderate = DifficultyLevel(
      name: 'Moderate', difficultyColor: TimberlandColor.primary);

  static const DifficultyLevel hard = DifficultyLevel(
      name: 'Hard', difficultyColor: TimberlandColor.secondaryColor);
}
