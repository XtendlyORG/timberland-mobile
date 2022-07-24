// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:timberland_biketrail/features/booking/domain/entities/booking.dart';
import 'package:timberland_biketrail/features/history/domain/entities/history.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';

class BookingHistory extends History {
  final Trail trail;
  final Booking booking;
  const BookingHistory({
    required this.trail,
    required this.booking,
  });
}
