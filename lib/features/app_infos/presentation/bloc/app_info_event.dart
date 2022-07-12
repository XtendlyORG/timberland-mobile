part of 'app_info_bloc.dart';

abstract class AppInfoEvent extends Equatable {
  const AppInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailRulesEvent extends AppInfoEvent {
  const FetchTrailRulesEvent();
}
