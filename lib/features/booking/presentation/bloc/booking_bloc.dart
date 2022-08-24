// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/domain/params/create_booking_params.dart';
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
      final result = await repository.submitBookingRequest(event.params);
      result.fold(
        (l) {},
        (checkoutHtml) {
          emit(BookingSubmitted(
            checkoutHtml: checkoutHtml,
            bookingParameter: CreateBookingParameter(
              fullName: event.params.customerFullname,
              mobileNumber: event.params.mobileNumber,
              email: event.params.email,
              date: event.params.date,
              time: event.params.time,
            ),
          ));
        },
      );
    });

    on<CreateBookingEvent>((event, emit) async {
      final result = await repository.createBooking(event.parameter);

      result.fold(
        (l) {},
        (r) {
          emit(BookingCreated());
        },
      );
    });
  }
}
