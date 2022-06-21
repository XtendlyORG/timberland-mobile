// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Trail extends Equatable {
  final String trailId;
  final String trailName;
  final String difficulty;
  const Trail({
    required this.trailId,
    required this.trailName,
    required this.difficulty,
  });

  @override
  List<Object> get props => [trailId, trailName, difficulty];
}
