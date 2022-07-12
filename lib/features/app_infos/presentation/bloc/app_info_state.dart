// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_info_bloc.dart';

abstract class AppInfoState extends Equatable {
  const AppInfoState();

  @override
  List<Object> get props => [];
}

class AppInfoInitial extends AppInfoState {}

class LoadingTrailRules extends AppInfoState {
  const LoadingTrailRules();
}

class TrailRulesLoaded extends AppInfoState {
  final List<TrailRule> trailRules;
  const TrailRulesLoaded({
    required this.trailRules,
  });
  @override
  List<Object> get props => super.props..add(trailRules);
}

class TrailRuleError extends AppInfoState {
  final String message;
  const TrailRuleError({
    required this.message,
  });
  @override
  List<Object> get props => super.props..add(message);
}
