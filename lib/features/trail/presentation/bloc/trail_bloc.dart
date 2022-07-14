// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';

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
        (failure) => emit(
          const TrailsLoaded(trails: [
            Trail(
              trailId: "trail-id",
              length: 90,
              elevationGain: 123,
              featureImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              mapImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              routeType: "Loop",
              trailName: 'Timberland Blue Trail to Nursery Loop',
              difficulty: Difficulties.easy,
              description:
                  'Qui ut eiusmod consequat minim. Magna sit do dolor tempor culpa do sint duis esse irure cupidatat Lorem. Eu ad mollit sint cupidatat labore culpa nostrud consectetur cillum incididunt. Reprehenderit exercitation fugiat sit in ea enim qui nisi ipsum irure eiusmod nulla sit.',
              location: 'San Mateo, Quezon, Philippines',
            ),
            Trail(
              trailId: "trail-id-2",
              length: 90,
              elevationGain: 123,
              featureImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              mapImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              routeType: "Loop",
              trailName: 'Trail Name 2',
              difficulty: Difficulties.moderate,
              description: '',
              location: '',
            ),
            Trail(
              trailId: "trail-id-3",
              length: 90,
              elevationGain: 123,
              featureImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              mapImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              routeType: "Loop",
              trailName: 'Trail Name 4',
              difficulty: Difficulties.hard,
              description: '',
              location: '',
            ),
            Trail(
              trailId: "trail-id-4",
              length: 90,
              elevationGain: 123,
              featureImageUrl: 'asd',
              mapImageUrl: 'asd',
              routeType: "Loop",
              trailName: 'Trail Name 4',
              difficulty: Difficulties.easy,
              description: '',
              location: '',
            ),
          ]),
        ),
        (trails) => emit(TrailsLoaded(trails: trails)),
      );
    });
  }
}
