// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class SubmittingBookingRequest extends BookingState {}

class BookingError extends BookingState {
  final String errorMessage;
  const BookingError({
    required this.errorMessage,
  });
  @override
  List<Object> get props => super.props..addAll([errorMessage, DateTime.now()]);
}

class DuplicateBookingError extends BookingError {
  const DuplicateBookingError({required super.errorMessage});
}

class BookingSubmitted extends BookingState {
  final String checkoutHtml;
  final bool isFree;

  const BookingSubmitted({
    required this.checkoutHtml,
    required this.isFree,
  });

  @override
  List<Object> get props => super.props
    ..addAll([
      checkoutHtml,
      isFree,
    ]);
}

abstract class CheckoutState extends BookingState {}

class CheckingOut extends CheckoutState {}

class CheckedOut extends CheckoutState {}

class CheckOutError extends CheckoutState {
  final String errorMessage;
  CheckOutError({
    required this.errorMessage,
  });
}
