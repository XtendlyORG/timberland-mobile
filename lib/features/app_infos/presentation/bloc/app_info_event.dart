part of 'app_info_bloc.dart';

abstract class AppInfoEvent {
  const AppInfoEvent();
}

class FetchTrailRulesEvent extends AppInfoEvent {
  const FetchTrailRulesEvent();
}

class FetchFAQSEvent extends AppInfoEvent {
  const FetchFAQSEvent();
}
