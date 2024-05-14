import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/blocked_booking_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/models/blocked_booking_model.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/blocked_booking_dates_repository.dart';

class BlockedBookingRepositoryImpl implements BlockedBookingRepository {
  final BlockedBookingDatasource bookingDatasource;
  BlockedBookingRepositoryImpl({
    required this.bookingDatasource,
  });

  @override
  Future<dynamic> getBookings() async {
    try {
      final List bookingsResult = await bookingDatasource.blockedBookingsRequest();
      debugPrint("This is the repository");
      return bookingsResult.map((e) => BlockedBookingsModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      return "Error: Failed to load bookings";
    }
  }
}