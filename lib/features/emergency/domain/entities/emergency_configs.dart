// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class EmergencyConfigs extends Equatable {
  final String appID;
  final String token;
  final String channelID;
  final int uid;
  const EmergencyConfigs({
    required this.appID,
    required this.token,
    required this.channelID,
    required this.uid,
  });

  @override
  List<Object> get props => [appID, token, channelID, uid];
}
