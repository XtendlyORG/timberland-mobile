// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trail_bloc.dart';

abstract class TrailState extends Equatable {
  const TrailState();

  @override
  List<Object> get props => [];
}

class TrailInitial extends TrailState {}

class TrailsLoaded extends TrailState {
  final List<Trail> trails;
  const TrailsLoaded({
    required this.trails,
  });
  @override
  List<Object> get props => super.props..add(trails);
}
