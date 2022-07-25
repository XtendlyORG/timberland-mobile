import 'dart:developer';

import '../../domain/entities/difficulty.dart';
import '../../domain/entities/trail.dart';

class TrailModel extends Trail {
  const TrailModel({
    required super.trailId,
    required super.trailName,
    required super.difficulty,
    required super.description,
    required super.distance,
    required super.routeType,
    required super.featureImageUrl,
    required super.mapImageUrl,
  });

  factory TrailModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return TrailModel(
      trailId: (map['trail_id'] as num).toString(),
      trailName: map['name'] as String,
      difficulty: DifficultyLevel.fromInt((map['difficulty'] as num).toInt()),
      description: map['description'] as String,
      distance: double.tryParse((map['distance'] as String?) ?? '') ?? 0,
      routeType: map['route_type'] as String,
      featureImageUrl: map['featured_image'] as String,
      mapImageUrl: map['map_image'] as String,
    );
  }
}
