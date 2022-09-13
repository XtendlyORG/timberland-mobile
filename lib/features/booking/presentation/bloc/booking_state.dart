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
