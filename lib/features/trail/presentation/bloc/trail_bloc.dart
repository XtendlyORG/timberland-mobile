// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';

part 'trail_event.dart';
part 'trail_state.dart';

class TrailBloc extends Bloc<TrailEvent, TrailState> {
  final TrailRepository repository;
  TrailBloc({
    required this.repository,
  }) : super(TrailInitial()) {
    on<TrailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchTrailsEvent>((event, emit) async {
      emit(const LoadingTrails());
      final result = await repository.fetchTrails(event.fetchTrailsParams);

      result.fold(
        (failure) => emit(TrailError(message: failure.message)),
        (trails) => emit(TrailsLoaded(trails: trails)),
      );
    });
  }
}
