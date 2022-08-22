// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class FetchAvailabilityEvent extends BookingEvent {
  const FetchAvailabilityEvent();
}


class SubmitBookingRequest extends BookingEvent{
  
}