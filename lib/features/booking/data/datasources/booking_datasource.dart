import '../../domain/entities/booking_response.dart';
import '../../domain/params/booking_request_params.dart';

abstract class BookingDatasource {
  Future<BookingResponse> submitBookingRequest(BookingRequestParams params);
}
  