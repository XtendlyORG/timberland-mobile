part of 'app_info_bloc.dart';

abstract class AppInfoEvent extends Equatable {
  const AppInfoEvent();

  @override
  List<Object> get props => [];
}

class FetchTrailRules extends AppInfoEvent {
  const FetchTrailRules();
}
