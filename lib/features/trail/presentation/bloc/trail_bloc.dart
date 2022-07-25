// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/params/search_trails.dart';
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
        (failure) => emit(
          const TrailsLoaded(trails: [
            Trail(
              trailId: "trail-id",
              distance: 90,
              featureImageUrl:
                  'https://gttp.imgix.net/328721/x/0/17-best-biking-spots-in-manila-and-nearby-bike-trails-scenic-routes-beginner-friendly-9.jpg?auto=compress%2Cformat&ch=Width%2CDPR&dpr=1&ixlib=php-3.3.0&w=883',
              mapImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              routeType: "Loop",
              trailName: 'Timberland Blue Trail to Nursery Loop',
              difficulty: Difficulties.easy,
              description:
                  'Qui ut eiusmod consequat minim. Magna sit do dolor tempor culpa do sint duis esse irure cupidatat Lorem. Eu ad mollit sint cupidatat labore culpa nostrud consectetur cillum incididunt. Reprehenderit exercitation fugiat sit in ea enim qui nisi ipsum irure eiusmod nulla sit.',
            ),
            Trail(
              trailId: "trail-id",
              distance: 90,
              featureImageUrl:
                  'https://gttp.imgix.net/328721/x/0/17-best-biking-spots-in-manila-and-nearby-bike-trails-scenic-routes-beginner-friendly-9.jpg?auto=compress%2Cformat&ch=Width%2CDPR&dpr=1&ixlib=php-3.3.0&w=883',
              mapImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              routeType: "Loop",
              trailName: 'Timberland Blue Trail to Nursery Loop',
              difficulty: Difficulties.intermediate,
              description:
                  'Qui ut eiusmod consequat minim. Magna sit do dolor tempor culpa do sint duis esse irure cupidatat Lorem. Eu ad mollit sint cupidatat labore culpa nostrud consectetur cillum incididunt. Reprehenderit exercitation fugiat sit in ea enim qui nisi ipsum irure eiusmod nulla sit.',
            ),
            Trail(
              trailId: "trail-id",
              distance: 90,
              featureImageUrl:
                  'https://gttp.imgix.net/328721/x/0/17-best-biking-spots-in-manila-and-nearby-bike-trails-scenic-routes-beginner-friendly-9.jpg?auto=compress%2Cformat&ch=Width%2CDPR&dpr=1&ixlib=php-3.3.0&w=883',
              mapImageUrl:
                  'https://live.staticflickr.com/7300/9151350000_8c94e1511a_b.jpg',
              routeType: "Loop",
              trailName: 'Timberland Blue Trail to Nursery Loop',
              difficulty: Difficulties.expert,
              description:
                  'Qui ut eiusmod consequat minim. Magna sit do dolor tempor culpa do sint duis esse irure cupidatat Lorem. Eu ad mollit sint cupidatat labore culpa nostrud consectetur cillum incididunt. Reprehenderit exercitation fugiat sit in ea enim qui nisi ipsum irure eiusmod nulla sit.',
            ),
          ]),
        ),
        (trails) => emit(AllTrailsLoaded(trails: trails)),
      );
    });

    on<SearchTrailsEvent>((event, emit) async {
      emit(const SearchingTrails());
      final result = await repository.searchTrails(event.searchParams);

      result.fold(
        (failure) {
          emit(TrailError(message: failure.message));
        },
        (trails) {
          emit(SearchResultsLoaded(
            searchParams: event.searchParams,
            trails: trails,
          ));
        },
      );
    });

    on<SearchTrailMapEvent>((event, emit) async {
      emit(TrailMapLoaded());
    });
  }
}
