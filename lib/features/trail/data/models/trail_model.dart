import 'dart:convert';

import '../../domain/entities/difficulty.dart';
import '../../domain/entities/featured_image.dart';
import '../../domain/entities/trail.dart';

class TrailModel extends Trail {
  const TrailModel({
    required super.trailId,
    required super.trailName,
    required super.difficulty,
    required super.description,
    required super.distance,
    required super.unit,
    required super.routeType,
    required super.featureImageUrl,
    required super.mapImageUrl,
    super.expectedDescription,
  });

  factory TrailModel.fromMap(Map<String, dynamic> map) {
    List<dynamic> jsonList = json.decode(map['featured_image']);
    List<FeaturedImage> images = jsonList.map((json) => FeaturedImage.fromJson(json)).toList();

    List<dynamic> highlightsJson = json.decode(map['trail_video']);
    List<FeaturedImage> highlights = highlightsJson.map((json) => FeaturedImage.fromJson(json)).toList();

    return TrailModel(
      trailId: (map['trail_id'] as num).toString(),
      trailName: map['name'] as String,
      difficulty: DifficultyLevel.fromString(map['difficulty'] as String),
      description: map['description'] as String,
      unit: map['distance_unit'] as String? ?? 'm',
      distance: (map['distance'] as num?)?.toDouble() ?? 0,
      routeType: map['route_type'] as String,
      featureImageUrl: images,
      mapImageUrl: highlights,
      expectedDescription: map['expected'] as String?,
    );
  }
}
