// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationRecieved extends NotificationsState {
  final bool onForeground;
  const NotificationRecieved({
    required this.onForeground,
  });
  @override
  List<Object> get props => super.props..add(DateTime.now());
}

class IncomingCallNotification extends NotificationsState {
  final EmergencyConfigs configs;
  const IncomingCallNotification({
    required this.configs,
  });
  @override
  List<Object> get props => super.props..add(configs);
}
