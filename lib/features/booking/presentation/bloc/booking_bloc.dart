// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;
  BookingBloc({
    required this.repository,
  }) : super(BookingInitial()) {
    on<FetchAvailabilityEvent>((event, emit) async {
      emit(const BookingAvailabilityLoaded());
    });

    on<SubmitBookingRequest>((event, emit) async {
      repository.submitBookingRequest();
    });
  }
}
