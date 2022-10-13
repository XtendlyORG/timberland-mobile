// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/inquiry.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';
import 'package:timberland_biketrail/features/app_infos/domain/repositories/app_infos_repository.dart';

part 'app_info_event.dart';
part 'app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent, AppInfoState> {
  final AppInfoRepository repository;

  AppInfoBloc({
    required this.repository,
  }) : super(AppInfoInitial()) {
    // on<FetchTrailRulesEvent>((event, emit) async {
    //   emit(const LoadingTrailRules());
    //   final result = await repository.fetchTrailRules();
    //   result.fold(
    //     (failure) {
    //       emit(TrailRulesError(message: failure.message));
    //     },
    //     (trailRules) {
    //       emit(TrailRulesLoaded(trailRules: trailRules));
    //     },
    //   );
    // });

    // on<FetchFAQSEvent>((event, emit) async {
    //   emit(const LoadingFAQs());
    //   final result = await repository.fetchFAQs();
    //   result.fold(
    //     (failure) {
    //       emit(FAQError(message: failure.message));
    //     },
    //     (faqs) {
    //       emit(FAQsLoaded(faqs: faqs));
    //     },
    //   );
    // });

    on<SendInquiryEvent>((event, emit) async {
      emit(SendingInquiry());

      final result = await repository.sendInquiry(event.inquiry);
      result.fold(
        (l) {
          emit(InquiryError(errorMessage: l.message));
        },
        (r) {
          emit(InquirySent());
        },
      );
    });
  }
}
