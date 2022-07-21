// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';

class SearchTrailsParams {
  final String name;
  final List<DifficultyLevel> difficulties;
  const SearchTrailsParams({
    required this.name,
    required this.difficulties,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'difficulty':
          difficulties.first.name // difficulties.map((x) => x.name).toList(),
    };
  }
}
