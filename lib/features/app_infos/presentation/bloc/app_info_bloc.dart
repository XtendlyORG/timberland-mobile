import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

part 'app_info_event.dart';
part 'app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent, AppInfoState> {
  AppInfoBloc()
      : super(
          const TrailRulesLoaded(
            trailRules: [
              TrailRule(
                rule: "Trail Rule 1",
                note:
                    "In ad exercitation minim nisi duis nulla Lorem. Ipsum minim culpa cupidatat laborum. Ipsum commodo occaecat et ea laboris ad consectetur culpa. Deserunt ea velit in qui sint anim et dolore incididunt. Nulla do cupidatat deserunt magna enim ex est ipsum duis cupidatat tempor anim incididunt in.",
              ),
              TrailRule(
                rule: "Trail Rule 2",
                note:
                    "In ad exercitation minim nisi duis nulla Lorem. Ipsum minim culpa cupidatat laborum. Ipsum commodo occaecat et ea laboris ad consectetur culpa. Deserunt ea velit in qui sint anim et dolore incididunt. Nulla do cupidatat deserunt magna enim ex est ipsum duis cupidatat tempor anim incididunt in.",
              ),
            ],
          ),
        ) {
    on<AppInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
