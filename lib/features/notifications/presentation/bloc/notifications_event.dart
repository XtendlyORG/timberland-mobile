// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notifications_bloc.dart';

abstract class NotificationsEvent extends Equatable {
  const NotificationsEvent();

  @override
  List<Object> get props => [];
}

class CheckForFCMTokenUpdate extends NotificationsEvent {}

class NotificationRecievedEvent extends NotificationsEvent {}

class NotificationOnBackground extends NotificationsEvent {}

class IncomingCallEvent extends NotificationsEvent {
  final EmergencyConfigs configs;
  const IncomingCallEvent({
    required this.configs,
  });

  @override
  List<Object> get props => super.props..add(configs);
}
