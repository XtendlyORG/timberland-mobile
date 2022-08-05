// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'trail_bloc.dart';

abstract class TrailEvent extends Equatable {
  const TrailEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailsEvent extends TrailEvent {
  final FetchTrailsParams fetchTrailsParams;
  const FetchTrailsEvent({
    required this.fetchTrailsParams,
  });
  @override
  List<Object> get props => super.props..add(fetchTrailsParams);
}

class SearchTrailsEvent extends TrailEvent {
  final SearchTrailsParams searchParams;
  const SearchTrailsEvent({
    required this.searchParams,
  });
}

class SaveTrailMapEvent extends TrailEvent {
  final File imageFile;
  const SaveTrailMapEvent({
    required this.imageFile,
  });

  @override
  List<Object> get props => super.props..add(imageFile);
}
