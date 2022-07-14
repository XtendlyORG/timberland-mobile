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
          emit(TrailRulesLoaded(trailRules: [
            TrailRule(
                ruleId: 'ruleId',
                rule: 'Trail Rule 1',
                note:
                    'Sint velit commodo adipisicing cupidatat consectetur Lorem eiusmod magna reprehenderit quis veniam officia sunt. Cillum cupidatat reprehenderit laboris sint ad occaecat dolor voluptate consectetur. Cupidatat dolor labore nostrud amet deserunt. Aute officia velit quis aliquip. Veniam exercitation culpa sint adipisicing in fugiat ad commodo commodo. Ipsum ex sint sint aliqua ut excepteur ullamco excepteur adipisicing enim cupidatat exercitation ea.'),
          ]));
        },
        (trailRules) {
          emit(TrailRulesLoaded(trailRules: trailRules));
        },
      );
    });
  }
}
