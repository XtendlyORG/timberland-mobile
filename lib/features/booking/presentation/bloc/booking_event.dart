// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}
class FetchTrailAvailabilityEvent extends BookingEvent {
  final Trail trail;
  const FetchTrailAvailabilityEvent({
    required this.trail,
  });
}

class FetchAllTrailsBookingEvent extends BookingEvent {}

class PopulateTrailsEvent extends BookingEvent {
  final List<Trail> trails;
  const PopulateTrailsEvent({
    required this.trails,
  });
}
