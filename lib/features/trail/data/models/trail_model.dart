import '../../domain/entities/difficulty.dart';
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
    return TrailModel(
      trailId: (map['trail_id'] as num).toString(),
      trailName: map['name'] as String,
      difficulty:
          DifficultyLevel.fromInt((map['difficulty'] as num?)?.toInt() ?? 0),
      description: map['description'] as String,
      unit: map['distance_unit'] as String? ?? 'm',
      distance: (map['distance'] as num?)?.toDouble() ?? 0,
      routeType: map['route_type'] as String,
      featureImageUrl: map['featured_image'] as String,
      mapImageUrl: map['trail_video'] as String,
      expectedDescription: map['expected'] as String?,
    );
  }
}
