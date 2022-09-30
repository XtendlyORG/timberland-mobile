// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/emergency/domain/entities/emergency_configs.dart';
import 'package:timberland_biketrail/features/emergency/domain/repositories/emergency_repository.dart';

part 'emergency_event.dart';
part 'emergency_state.dart';

class EmergencyBloc extends Bloc<EmergencyEvent, EmergencyState> {
  final EmergencyRepository repository;
  EmergencyBloc({
    required this.repository,
  }) : super(EmergencyInitial()) {
    on<FetchEmergencyTokenEvent>((event, emit) async {
      final result = await repository.fetchToken(event.channelID);

      result.fold(
        (failure) {},
        (emergencyConfigs) {
          emit(EmergencyTokenFetched(configs: emergencyConfigs));
        },
      );
    });
  }
}
