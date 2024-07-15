// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/booking/data/models/announcement_model.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/announcement_repository.dart';
import 'package:timberland_biketrail/features/constants/helpers.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/notifications/domain/entities/announcement.dart';
import 'package:timberland_biketrail/features/notifications/domain/repositories/push_notif_repository.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final PushNotificationRepository repository;
  final AnnouncementRepository announcementRepository;
  NotificationsBloc({
    required this.repository,
    required this.announcementRepository,
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
    on<IncomingCallEvent>((event, emit) {
      log('Incoming call event recieved');
      log("1ic${event.configs.channelID}");
      log("1ic${event.configs.token}");
      log("1ic${event.configs.emergencyId}");
      log("1ic${event.configs.uid}");

      emit(
        IncomingCallNotification(configs: event.configs),
      );
    });

    on<FetchLatestAnnouncement>((event, emit) async {
      if (Session().currentUser == null) {
        log('No user logged in');
        return;
      }
      log('fetching announcements');
      try {
        final result = await announcementRepository.getAnnouncements();
        List<AnnouncementModel> filterList = result.isNotEmpty
          ? result.where((notif) => dateIsWithinRange(DateTime.now(), DateTime.tryParse(notif.pushDateTime ?? DateTime.now().toString()), DateTime.tryParse(notif.expiredDateTime ?? DateTime.now().toString()))).toList()
          : [];
        filterList.sort((ntf1, ntf2) => compareInt(true, (ntf1.order ?? 1), (ntf2.order ?? 1)));
        emit(AnnouncementRecieved(
          announcements: [Announcement(
            title: "",
            content: "",
            dateCreated: DateTime.now(),
            id: ""
          )],
          announcementsList: filterList
        ));
      } catch (e) {
        log("ERROR: Failed to load announcement ${e.toString()}");
      }
    });

    // on<FetchLatestAnnouncement>((event, emit) async {
    //   if (Session().currentUser == null) {
    //     log('No user logged in');
    //     return;
    //   }
    //   log('fetching announcements');
    //   final result = await repository.checkForAnnouncements();

    //   result.fold(
    //     (l) {
    //       //TODO: emit error state
    //       log(l.message.toString());
    //     },
    //     (r) {
    //       log(r.toString());
    //       if (r != null) {
    //         emit(AnnouncementRecieved(announcements: r));
    //       }
    //     },
    //   );
    // });
  }
}
