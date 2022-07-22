import 'dart:developer';

import '../../domain/entities/difficulty.dart';
import '../../domain/entities/trail.dart';

class TrailModel extends Trail {
  const TrailModel({
    required super.trailId,
    required super.trailName,
    required super.difficulty,
    required super.description,
    required super.location,
    required super.length,
    required super.elevationGain,
    required super.routeType,
    required super.featureImageUrl,
    required super.mapImageUrl,
  });

  factory TrailModel.fromMap(Map<String, dynamic> map) {
    log(map.toString());
    return TrailModel(
      trailId: (map['trail_id'] as num).toString(),
      trailName: map['name'] as String,
      difficulty: DifficultyLevel.fromString(
          (map['difficulty_level'] as String).toLowerCase()),
      description: map['description'] as String,
      location: map['location'] as String,
      length: (map['length'] as num).toDouble(),
      elevationGain: (map['elevation_gain'] as num).toDouble(),
      routeType: map['route_type'] as String,
      featureImageUrl: map['featured_image'] as String,
      mapImageUrl: map['map_image'] as String,
    );
  }
}
