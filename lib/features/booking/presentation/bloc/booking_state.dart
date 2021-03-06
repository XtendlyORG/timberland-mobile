// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class LoadingBookingAvailability extends BookingState {}

class BookingAvailabilityLoaded extends BookingState {
  const BookingAvailabilityLoaded();
}
