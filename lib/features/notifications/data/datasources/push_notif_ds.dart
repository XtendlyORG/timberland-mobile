abstract class PushNotificationRemoteDataSource {
  Future<void> updateToken(String memberId, String token);
}
