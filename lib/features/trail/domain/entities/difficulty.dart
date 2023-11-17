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
      case 'novice':
        return Difficulties.intermediate;
      case 'intermediate':
        return Difficulties.intermediate;
      case 'advanced':
        return Difficulties.advanced;
      case 'expert':
        return Difficulties.expert;
      /*  case 'extremely difficult':
        return Difficulties.exteremelyDifficult; */
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
    novice,
    intermediate,
    // intermediate,
    advanced,
    expert,
    //exteremelyDifficult,
  ];

  static const DifficultyLevel novice = DifficultyLevel(
    id: 1,
    name: 'Novice',
    primaryColor: TimberlandColor.background,
    secondaryColor: TimberlandColor.accentColor,
    icon: Icon(
      Icons.circle,
      color: Colors.white,
    ),
  );

  static const DifficultyLevel intermediate = DifficultyLevel(
    id: 2,
    name: 'Intermediate',
    primaryColor: TimberlandColor.accentColor,
    secondaryColor: TimberlandColor.background,
    icon: Icon(
      Icons.circle,
      color: Colors.green,
    ),
  );

  static const DifficultyLevel advanced = DifficultyLevel(
    id: 3,
    name: 'Advanced',
    primaryColor: Color(0xff34459b),
    secondaryColor: TimberlandColor.background,
    icon: Icon(
      Icons.square,
      color: TimberlandColor.primary,
    ),
  );

  static const DifficultyLevel expert = DifficultyLevel(
    id: 4,
    name: 'Expert',
    primaryColor: TimberlandColor.text,
    secondaryColor: TimberlandColor.background,
    icon: FaqDiamondIcon(
      count: 1,
    ),
  );

  /*  static const DifficultyLevel exteremelyDifficult = DifficultyLevel(
    id: 5,
    name: 'Extremely Difficult',
    primaryColor: TimberlandColor.text,
    secondaryColor: TimberlandColor.background,
    icon: FaqDiamondIcon(
      count: 2,
    ),
  ); */
}
