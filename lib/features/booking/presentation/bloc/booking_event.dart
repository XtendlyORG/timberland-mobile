// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class SubmitBookingRequest extends BookingEvent {
  final BookingRequestParams params;

  const SubmitBookingRequest({
    required this.params,
  });
  @override
  List<Object> get props => super.props..add(params);
}

class CheckoutBooking extends BookingEvent {
  final String bookingId;
  const CheckoutBooking({
    required this.bookingId,
  });
  @override
  List<Object> get props => super.props..add(bookingId);
}
