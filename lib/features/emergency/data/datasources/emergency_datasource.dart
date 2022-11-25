import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';

abstract class EmergencyDataSource {
  Future<EmergencyConfigs> fetchToken(String channelID);
  Future<void> disconnectFromSocket();
  Future<void> reconnectToChannel(String channelID);
  Future<void> connectToSocket({
    required void Function(EmergencyConfigs configs) onIncomingCall,
  });
}
