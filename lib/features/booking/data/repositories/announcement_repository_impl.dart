import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:timberland_biketrail/features/booking/data/datasources/announcement_datasource.dart';
import 'package:timberland_biketrail/features/booking/data/models/announcement_model.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/announcement_repository.dart';

class AnnouncementRepositoryImpl implements AnnouncementRepository {
  final AnnouncementDatasource announcementDatasource;
  AnnouncementRepositoryImpl({
    required this.announcementDatasource,
  });

  @override
  Future<List<AnnouncementModel>> getAnnouncements() async {
    try {
      final List bookingsResult = await announcementDatasource.getAnnouncements();
      debugPrint("This is the announcement repository");
      return bookingsResult.map((e) => AnnouncementModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      debugPrint("Error: Failed to load announcement ${e.toString()}");
      return [];
    }
  }
}