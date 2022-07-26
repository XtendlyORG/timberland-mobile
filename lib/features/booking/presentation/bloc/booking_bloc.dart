// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/domain/params/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/domain/repositories/trail_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final TrailRepository trailRepository;
  BookingBloc({
    required this.trailRepository,
  }) : super(BookingInitial()) {
    on<PopulateTrailsEvent>((event, emit) {
      log("TrailsPopulated");
      emit(BookingAvailabilityLoaded(trails: event.trails));
    });

    on<FetchAllTrailsBookingEvent>(
      (event, emit) async {
        List<Trail> trails;
        if (state is BookingAvailabilityLoaded) {
          trails = (state as BookingAvailabilityLoaded).trails;
        } else {
          emit(LoadingBookingAvailability());
          final result = await trailRepository.fetchTrails(FetchTrailsParams());
          trails = result.fold(
            (failure) => [],
            (trails) => trails,
          );
        }

        emit(BookingAvailabilityLoaded(
          trails: trails,
        ));
      },
    );

    on<FetchTrailAvailabilityEvent>((event, emit) async {});
  }
}
