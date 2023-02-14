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
  final EmergencyConfigs? configs; // For call incoming notification
  final String? bookingID; // For check out notification
  const NotificationRecieved({
    required this.onForeground,
    this.configs,
    this.bookingID,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      DateTime.now(),
      if (configs != null) configs!,
    ]);
}

class IncomingCallNotification extends NotificationsState {
  final EmergencyConfigs configs;
  const IncomingCallNotification({
    required this.configs,
  });
  @override
  List<Object> get props => super.props..add(configs);
}

class AnnouncementRecieved extends NotificationsState {
  final List<Announcement> announcements;
  const AnnouncementRecieved({
    required this.announcements,
  });

  @override
  List<Object> get props => [announcements];
}
