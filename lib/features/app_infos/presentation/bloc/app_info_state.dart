// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_info_bloc.dart';

abstract class AppInfoState extends Equatable {
  const AppInfoState();

  @override
  List<Object?> get props => [];
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
  @override
  List<Object?> get props => super.props..add(trailRules);
}

class TrailRulesError extends TrailRulesState {
  final String message;
  const TrailRulesError({
    required this.message,
  });

  @override
  List<Object?> get props => super.props..add(message);
}

class LoadingFAQs extends FAQState {
  const LoadingFAQs();
}

class FAQsLoaded extends FAQState {
  final List<FAQ> faqs;
  const FAQsLoaded({
    required this.faqs,
  });
  @override
  List<Object?> get props => super.props..add(faqs);
}

class FAQError extends FAQState {
  final String message;
  const FAQError({
    required this.message,
  });
}

abstract class ContactState extends AppInfoState {}

class InquirySent extends ContactState {
  final Inquiry inquiry;
  InquirySent({
    required this.inquiry,
  });
  @override
  List<Object?> get props => super.props..add(inquiry);
}
