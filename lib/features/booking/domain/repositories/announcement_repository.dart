import 'package:timberland_biketrail/core/utils/repository.dart';
import 'package:timberland_biketrail/features/booking/data/models/announcement_model.dart';

abstract class AnnouncementRepository extends Repository {
  Future<List<AnnouncementModel>> getAnnouncements();
}