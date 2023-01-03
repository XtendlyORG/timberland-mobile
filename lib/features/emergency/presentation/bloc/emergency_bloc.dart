// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/dependency_injection/dependency_injection.dart'
    as di;
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/emergency/domain/repositories/emergency_repository.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';

part 'emergency_event.dart';
part 'emergency_state.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  final EmergencyRepository repository;
  EmergencyBloc({
    required this.repository,
  }) : super(EmergencyInitial()) {
    on<AnswerIncomingCallEvent>(
      (event, emit) {
        emit(EmergencyTokenFetched(configs: event.configs));
      },
    );

    on<RegisterMissedCallEvent>((event, emit) {
      repository.registerMissedCall(event.config);
    });

    on<DeclineCallEvent>((event, emit) {
      repository.declineCall(event.memberID);
    });
    on<FetchEmergencyTokenEvent>((event, emit) async {
      final result = await repository.fetchToken(event.channelID);

      result.fold(
        (failure) {
          log('Emergency Bloc', error: failure.message);
        },
        (emergencyConfigs) {
          log(emergencyConfigs.token, name: 'Emergency Bloc');
          emit(EmergencyTokenFetched(configs: emergencyConfigs));
        },
      );
    });
    on<DisconnectFromSocket>((event, emit) {
      repository.disconnectFromSocket();
    });
    on<ReconnectToSocket>((event, emit) async {
      final result = await repository.reconnectToChannel(event.config);
      result.fold((l) {
        log("Socket reconnection failed.");
      }, (r) {
        emit(
          EmergencyTokenFetched(
            configs: (state as EmergencyTokenFetched).configs,
          ),
        );
      });
    });

    on<ConnectToSocket>((event, emit) {
      log("Connecting to socket");
      repository.connectToSocket(
        onIncomingCall: (configs) {
          di.serviceLocator<NotificationsBloc>().add(
                IncomingCallEvent(configs: configs),
              );
        },
      );
    });
  }
}
