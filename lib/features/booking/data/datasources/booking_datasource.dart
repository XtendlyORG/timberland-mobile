import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/domain/params/create_booking_params.dart';

abstract class BookingDatasource {
  Future<String> submitBookingRequest(BookingRequestParams params);
  Future<void> createBooking(CreateBookingParameter params);
}
