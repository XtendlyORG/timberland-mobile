import 'package:timberland_biketrail/core/utils/repository.dart';
import 'package:timberland_biketrail/features/booking/data/models/blocked_booking_model.dart';

abstract class BlockedBookingRepository extends Repository {
  Future<dynamic> getBookings();
}