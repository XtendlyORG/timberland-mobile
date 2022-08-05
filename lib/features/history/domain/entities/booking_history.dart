// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:timberland_biketrail/features/booking/domain/entities/booking.dart';
import 'package:timberland_biketrail/features/history/domain/entities/history.dart';

class BookingHistory extends History {
  final Booking booking;
  const BookingHistory({
    required this.booking,
  });
}
