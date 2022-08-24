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

class SubmitBookingRequest extends BookingEvent {
  final BookingRequestParams params;

  const SubmitBookingRequest({
    required this.params,
  });
  @override
  List<Object> get props => super.props..add(params);
}

class CreateBookingEvent extends BookingEvent {
  final CreateBookingParameter parameter;
  const CreateBookingEvent({
    required this.parameter,
  });
  @override
  List<Object> get props => super.props..add(parameter);
}
