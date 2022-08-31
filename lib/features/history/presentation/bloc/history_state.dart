// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

abstract class PaymentState extends HistoryState {
  const PaymentState();
}
abstract class BookingState extends HistoryState {
  const BookingState();
}

class LoadingHistory extends HistoryState {
  final String loadingMessage;
  const LoadingHistory({
    required this.loadingMessage,
  });
}

class PaymentHistoryLoaded extends PaymentState {
  final List<PaymentHistory> payments;
  const PaymentHistoryLoaded({
    required this.payments,
  });

  @override
  List<Object> get props => super.props..add(payments);
}

class BookingHistoryLoaded extends BookingState {
  final List<BookingHistory> bookings;
  const BookingHistoryLoaded({
    required this.bookings,
  });

  @override
  List<Object> get props => super.props..add(bookings);
}

class HistoryError extends HistoryState {
  final String errorMessage;
  const HistoryError({
    required this.errorMessage,
  });
  @override
  List<Object> get props => super.props..add(errorMessage);
}
