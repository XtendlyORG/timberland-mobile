// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';
import 'package:timberland_biketrail/features/app_infos/domain/repositories/app_infos_repository.dart';

part 'app_info_event.dart';
part 'app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent, AppInfoState> {
  final AppInfoRepository repository;

  AppInfoBloc({
    required this.repository,
  }) : super(AppInfoInitial()) {
    on<AppInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchTrailRulesEvent>((event, emit) async {
      emit(const LoadingTrailRules());
      final result = await repository.fetchTrailRules();
      result.fold(
        (failure) {
          emit(TrailRuleError(message: failure.message));
        },
        (trailRules) {
          emit(TrailRulesLoaded(trailRules: trailRules));
        },
      );
    });
  }
}
