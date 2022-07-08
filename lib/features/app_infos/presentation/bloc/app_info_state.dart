// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_info_bloc.dart';

abstract class AppInfoState extends Equatable {
  const AppInfoState();

  @override
  List<Object> get props => [];
}

class AppInfoInitial extends AppInfoState {}

class TrailRulesLoaded extends AppInfoState {
  final List<TrailRule> trailRules;
  const TrailRulesLoaded({
    required this.trailRules,
  });
  @override
  List<Object> get props => super.props..add(trailRules);
}
