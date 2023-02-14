// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';
import 'package:timberland_biketrail/features/notifications/domain/repositories/push_notif_repository.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final PushNotificationRepository repository;
  NotificationsBloc({
    required this.repository,
  }) : super(NotificationsInitial()) {
    on<CheckForFCMTokenUpdate>((event, emit) async {
      final result = await repository.checkForFCMTokenUpdates();
      result.fold(
        (l) {
          // failed token update
        },
        (r) => null,
      );
    });
    on<NotificationRecievedEvent>((event, emit) {
      emit(NotificationsInitial());
      emit(
        NotificationRecieved(
          onForeground: event.onForeground,
          configs: event.configs,
          bookingID: event.bookingID,
        ),
      );
    });

    // on<NotificationOnBackground>((event, emit) {
    //   emit(NotificationsInitial());
    //   emit(const NotificationRecieved(onForeground: false));
    // });
    on<IncomingCallEvent>(
      (event, emit) => emit(
        IncomingCallNotification(configs: event.configs),
      ),
    );

    on<FetchLatestAnnouncement>((event, emit) async {
      if (Session().currentUser == null) {
        log('No user logged in');
        return;
      }
      log('fetching announcements');
      final result = await repository.checkForAnnouncements();

      result.fold(
        (l) {
          //TODO: emit error state
          log(l.message.toString());
        },
        (r) {
          log(r.toString());
          if (r != null) {
            
            emit(AnnouncementRecieved(announcements: r));
          }
        },
      );
    });
  }
}
