// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/history/domain/entities/entities.dart';
import 'package:timberland_biketrail/features/history/domain/repositories/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;
  HistoryBloc({
    required this.repository,
  }) : super(HistoryInitial()) {
    on<HistoryEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchBookingHistory>((event, emit) async {
      emit(const LoadingHistory(loadingMessage: 'Loading Bookings...'));
      final result = await repository.fetchBookingHistory();

      result.fold(
        (failure) {
          emit(HistoryError(errorMessage: failure.message));
        },
        (bookings) {
          emit(BookingHistoryLoaded(bookings: bookings));
        },
      );
    });

    on<FetchPaymentHistory>((event, emit) async {
      emit(const LoadingHistory(loadingMessage: 'Loading Payments...'));
      final result = await repository.fetchPaymentHistory();

      result.fold(
        (failure) {
          emit(HistoryError(errorMessage: failure.message));
        },
        (payments) {
          emit(PaymentHistoryLoaded(payments: payments));
        },
      );
    });

    on<CancelBookingEvent>((event, emit) async {
      final initalState = state as BookingHistoryLoaded;
      emit(const CancellingBooking());

      final result = await repository.cancelBooking(
        event.bookingId,
        event.reason,
      );

      result.fold(
        (failure) {
          emit(BookingCancellationError(errorMessage: failure.message));
        },
        (_) {
          final booking = initalState.bookings
              .firstWhere((element) => element.id == event.bookingId);
          final int bookingIndex = initalState.bookings.indexOf(booking);
          final bookings = initalState.bookings
            ..removeAt(bookingIndex)
            ..insert(
              bookingIndex,
              booking.copyWith(
                status: BookingStatus.cancelled,
              ),
            );
          emit(BookingHistoryLoaded(bookings: bookings));
          emit(const BookingCancelled());
        },
      );
    });
  }
}
