// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_diamond_icon.dart';

class DifficultyLevel {
  final int id;
  final String name;
  final Color primaryColor;
  final Color secondaryColor;
  final Widget icon;
  const DifficultyLevel({
    required this.id,
    required this.name,
    required this.primaryColor,
    required this.secondaryColor,
    required this.icon,
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
      case 'extremely difficult':
        return Difficulties.exteremelyDifficult;
      default:
        return DifficultyLevel(
          id: name.codeUnits.first,
          name: name,
          primaryColor: TimberlandColor.primary,
          secondaryColor: TimberlandColor.background,
          icon: const Icon(Icons.error),
        );
      // throw Exception(
      //   "Difficulty $name is not valid, append it to 'Difficulties' abstract object",
      // );
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
    exteremelyDifficult,
  ];

  static const DifficultyLevel easiest = DifficultyLevel(
    id: 1,
    name: 'Easiest',
    primaryColor: TimberlandColor.background,
    secondaryColor: TimberlandColor.accentColor,
    icon: Icon(
      Icons.circle,
      color: Colors.white,
    ),
  );

  static const DifficultyLevel easy = DifficultyLevel(
    id: 2,
    name: 'Easy',
    primaryColor: TimberlandColor.accentColor,
    secondaryColor: TimberlandColor.background,
    icon: Icon(
      Icons.circle,
      color: Colors.green,
    ),
  );

  static const DifficultyLevel moreDifficult = DifficultyLevel(
    id: 3,
    name: 'More Difficult',
    primaryColor: Color(0xff34459b),
    secondaryColor: TimberlandColor.background,
    icon: Icon(
      Icons.square,
      color: TimberlandColor.primary,
    ),
  );

  static const DifficultyLevel veryDifficult = DifficultyLevel(
    id: 4,
    name: 'Very Difficult',
    primaryColor: TimberlandColor.text,
    secondaryColor: TimberlandColor.background,
    icon: FaqDiamondIcon(
      count: 1,
    ),
  );

  static const DifficultyLevel exteremelyDifficult = DifficultyLevel(
    id: 5,
    name: 'Extremely Difficult',
    primaryColor: TimberlandColor.text,
    secondaryColor: TimberlandColor.background,
    icon: FaqDiamondIcon(
      count: 2,
    ),
  );
}
