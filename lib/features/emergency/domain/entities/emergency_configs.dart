// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class EmergencyConfigs extends Equatable {
  final String token;
  final String channelID;
  final int uid;
  final int emergencyId;
  const EmergencyConfigs({
    required this.token,
    required this.channelID,
    required this.uid,
    required this.emergencyId,
  });

  @override
  List<Object> get props => [token, channelID, uid, emergencyId];
}
