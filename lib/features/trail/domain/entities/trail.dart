// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';

class Trail extends Equatable {
  final String trailId;
  final String trailName;
  final DifficultyLevel difficulty;
  final String description;
  final double distance;
  final String unit;
  final String routeType;
  final String featureImageUrl;
  final String mapImageUrl;
  final String? expectedDescription;

  const Trail({
    required this.trailId,
    required this.trailName,
    required this.difficulty,
    required this.description,
    required this.distance,
    required this.unit,
    required this.routeType,
    required this.featureImageUrl,
    required this.mapImageUrl,
    this.expectedDescription,
  });

  @override
  List<Object> get props {
    return [
      trailId,
      trailName,
      difficulty,
      description,
      distance,
      unit,
      routeType,
      featureImageUrl,
      mapImageUrl,
      if (expectedDescription != null) expectedDescription!,
    ];
  }
}
