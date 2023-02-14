import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';

abstract class PushNotificationRemoteDataSource {
  Future<void> updateToken(String memberId, String token);
  Future<List<Announcement>?> fetchLatestAnnouncement();
}
