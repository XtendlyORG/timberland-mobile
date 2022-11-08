part of 'notifications_bloc.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationRecieved extends NotificationsState {
  @override
  List<Object> get props => super.props..add(DateTime.now());
}
