// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchPaymentHistory extends HistoryEvent {
  const FetchPaymentHistory();
}

class FetchBookingHistory extends HistoryEvent {
  const FetchBookingHistory();
}

class CancelBookingEvent extends HistoryEvent {
  final String bookingId;
  final String reason;
  const CancelBookingEvent({
    required this.bookingId,
    required this.reason,
  });

  @override
  List<Object> get props => super.props..add(bookingId);
}
