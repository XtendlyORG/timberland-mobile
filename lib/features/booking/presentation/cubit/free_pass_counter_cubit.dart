// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/booking/domain/repositories/booking_repository.dart';

part 'free_pass_counter_state.dart';

class FreePassCounterCubit extends Cubit<int?> {
  final BookingRepository repository;
  FreePassCounterCubit({
    required this.repository,
  }) : super(null);

  void getFreePassCount() async {
    final result = await repository.getFreePassCount();

    result.fold(
      (l) => null,
      (r) => emit(r),
    );
  }

  void increment() => emit(state! + 1);
  void decrement() => emit(state! - 1);
}
