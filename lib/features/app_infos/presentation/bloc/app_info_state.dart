// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_info_bloc.dart';

abstract class AppInfoState {
  const AppInfoState();
}

abstract class TrailRulesState extends AppInfoState {
  const TrailRulesState();
}

abstract class FAQState extends AppInfoState {
  const FAQState();
}

class AppInfoInitial extends AppInfoState {}

class LoadingTrailRules extends TrailRulesState {
  const LoadingTrailRules();
}

class TrailRulesLoaded extends TrailRulesState {
  final List<TrailRule> trailRules;
  const TrailRulesLoaded({
    required this.trailRules,
  });
}

class TrailRulesError extends TrailRulesState {
  final String message;
  const TrailRulesError({
    required this.message,
  });
}

class LoadingFAQs extends FAQState {
  const LoadingFAQs();
}

class FAQsLoaded extends AppInfoState {
  final List<FAQ> faqs;
  const FAQsLoaded({
    required this.faqs,
  });
}

class FAQError extends FAQState {
  final String message;
  const FAQError({
    required this.message,
  });
}
