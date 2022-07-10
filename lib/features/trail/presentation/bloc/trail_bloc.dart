import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/usecases/fetch_trails.dart';

part 'trail_event.dart';
part 'trail_state.dart';

class TrailBloc extends Bloc<TrailEvent, TrailState> {
  TrailBloc() : super(TrailInitial()) {
    on<TrailEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchTrailsEvent>((event, emit) {
      emit(const TrailsLoaded(trails: [
        Trail(
          trailId: "trail-id",
          trailName: 'Trail Name 1',
          difficulty: 'Easy',
        ),
        Trail(
          trailId: "trail-id-2",
          trailName: 'Trail Name 2',
          difficulty: 'Moderate',
        ),
        Trail(
          trailId: "trail-id-3",
          trailName: 'Trail Name 4',
          difficulty: 'Hard',
        ),
        Trail(
          trailId: "trail-id-4",
          trailName: 'Trail Name 4',
          difficulty: 'Moderate',
        ),
      ]));
    });
  }
}
