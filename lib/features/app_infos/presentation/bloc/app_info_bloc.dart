import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';

part 'app_info_event.dart';
part 'app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent, AppInfoState> {
  AppInfoBloc() : super(AppInfoInitial()) {
    on<AppInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
