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
