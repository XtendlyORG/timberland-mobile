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

class AllTrailsLoaded extends TrailsLoaded {
  const AllTrailsLoaded({
    required super.trails,
  });
}

class LoadingTrails extends TrailState {
  const LoadingTrails();
}

class TrailError extends TrailState {
  final String message;
  const TrailError({
    required this.message,
  });
  @override
  List<Object> get props => super.props..add(message);
}

abstract class SearchTrailState extends TrailState {
  const SearchTrailState();
}

class SearchingTrails extends LoadingTrails {
  const SearchingTrails();
}

class SearchResultsLoaded extends TrailsLoaded {
  final SearchTrailsParams searchParams;
  const SearchResultsLoaded({
    required super.trails,
    required this.searchParams,
  });
}
