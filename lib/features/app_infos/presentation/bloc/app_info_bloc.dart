// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:timberland_biketrail/features/app_infos/domain/entities/faq.dart';

import 'package:timberland_biketrail/features/app_infos/domain/entities/trail_rule.dart';
import 'package:timberland_biketrail/features/app_infos/domain/repositories/app_infos_repository.dart';

part 'app_info_event.dart';
part 'app_info_state.dart';

class AppInfoBloc extends Bloc<AppInfoEvent, AppInfoState> {
  final AppInfoRepository repository;

  AppInfoBloc({
    required this.repository,
  }) : super(AppInfoInitial()) {
    on<AppInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FetchTrailRulesEvent>((event, emit) async {
      emit(const LoadingTrailRules());
      final result = await repository.fetchTrailRules();
      result.fold(
        (failure) {
          emit(TrailRulesError(message: failure.message));
          emit(const TrailRulesLoaded(trailRules: [
            TrailRule(
                ruleId: 'ruleId',
                rule: 'Trail Rule 1',
                note:
                    'Sint velit commodo adipisicing cupidatat consectetur Lorem eiusmod magna reprehenderit quis veniam officia sunt. Cillum cupidatat reprehenderit laboris sint ad occaecat dolor voluptate consectetur. Cupidatat dolor labore nostrud amet deserunt. Aute officia velit quis aliquip. Veniam exercitation culpa sint adipisicing in fugiat ad commodo commodo. Ipsum ex sint sint aliqua ut excepteur ullamco excepteur adipisicing enim cupidatat exercitation ea.'),
          ]));
        },
        (trailRules) {
          emit(TrailRulesLoaded(trailRules: trailRules));
        },
      );
    });

    on<FetchFAQSEvent>((event, emit) async {
      emit(const LoadingFAQs());
      final result = await repository.fetchFAQs();
      result.fold(
        (failure) {
          emit(FAQError(message: failure.message));
          emit(
            const FAQsLoaded(
              faqs: [
                FAQ(
                  faqId: "faq-id-1",
                  question: "Question 1",
                  answer:
                      "Reprehenderit nulla incididunt cillum ea occaecat cupidatat. Elit laboris duis aliqua nulla ut anim proident duis reprehenderit qui. Laboris dolor sit minim enim eu occaecat sit laboris fugiat officia id officia non velit. Velit labore nostrud pariatur pariatur eiusmod proident veniam magna fugiat pariatur in. Proident incididunt minim elit veniam occaecat ullamco cupidatat voluptate est dolore officia nostrud. Non pariatur nostrud minim sit proident. In nisi sint voluptate quis ut officia anim aute anim et ea reprehenderit.",
                ),
                FAQ(
                  faqId: "faq-id-2",
                  question: "Question 2",
                  answer:
                      "Reprehenderit nulla incididunt cillum ea occaecat cupidatat. Elit laboris duis aliqua nulla ut anim proident duis reprehenderit qui. Laboris dolor sit minim enim eu occaecat sit laboris fugiat officia id officia non velit. Velit labore nostrud pariatur pariatur eiusmod proident veniam magna fugiat pariatur in. Proident incididunt minim elit veniam occaecat ullamco cupidatat voluptate est dolore officia nostrud. Non pariatur nostrud minim sit proident. In nisi sint voluptate quis ut officia anim aute anim et ea reprehenderit.",
                ),
              ],
            ),
          );
        },
        (faqs) {
          emit(FAQsLoaded(faqs: faqs));
        },
      );
    });
  }
}
