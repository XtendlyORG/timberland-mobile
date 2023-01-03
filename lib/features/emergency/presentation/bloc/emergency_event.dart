// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'emergency_bloc.dart';

abstract class EmergencyEvent extends Equatable {
  const EmergencyEvent();

  @override
  List<Object> get props => [];
}

class ConnectToSocket extends EmergencyEvent {}

class FetchEmergencyTokenEvent extends EmergencyEvent {
  final String channelID;
  const FetchEmergencyTokenEvent({
    required this.channelID,
  });

  @override
  List<Object> get props => super.props..add(channelID);
}

class DisconnectFromSocket extends EmergencyEvent {}

class ReconnectToSocket extends EmergencyEvent {
  final EmergencyConfigs config;
  const ReconnectToSocket({
    required this.config,
  });

  @override
  List<Object> get props => super.props..add(config);
}

class AnswerIncomingCallEvent extends EmergencyEvent {
  final EmergencyConfigs configs;
  const AnswerIncomingCallEvent({
    required this.configs,
  });
  @override
  List<Object> get props => super.props..add(configs);
}

class DeclineCallEvent extends EmergencyEvent {
  final String memberID;
  const DeclineCallEvent({
    required this.memberID,
  });
  @override
  List<Object> get props => super.props..add(memberID);
}

class RegisterMissedCallEvent extends EmergencyEvent {
  final EmergencyConfigs config;
  const RegisterMissedCallEvent({
    required this.config,
  });
  @override
  List<Object> get props => super.props..add(config);
}
