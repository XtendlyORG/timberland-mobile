// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingRepository repository;
  BookingBloc({
    required this.repository,
  }) : super(BookingInitial()) {
    on<SubmitBookingRequest>((event, emit) async {
      emit(SubmittingBookingRequest());
      final result = await repository.submitBookingRequest(event.params);
      result.fold(
        (failure) {
          if (failure is DuplicateBookingFailure) {
            emit(DuplicateBookingError(errorMessage: failure.message));
          } else {
            emit(BookingError(errorMessage: failure.message));
          }
        },
        (bookingResponse) {
          emit(
            BookingSubmitted(
              isFree: bookingResponse.isFree,
              checkoutHtml: bookingResponse.redirectUrl ??
                  'No redicrection, booking is free',
            ),
          );
        },
      );
    });
    on<CheckoutBooking>((event, emit) async {
      emit(CheckingOut());
      //TODO: Remove code below
      emit(CheckedOut());

      //TODO: uncomment codes below
      // final result = await repository.checkoutBooking(event.bookingId);
      // result.fold(
      // (l) => emit(CheckOutError(errorMessage: l.message)),
      // (r) => emit(CheckedOut()),
      // );
    });
  }
}
