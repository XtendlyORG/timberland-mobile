// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/dashboard/domain/repository/profile_repository.dart';

part 'profile_header_state.dart';

class ProfileHeaderCubit extends Cubit<ProfileHeaderState> {
  ProfileRepository repository;
  ProfileHeaderCubit({
    required this.repository,
  }) : super(ProfileHeaderInitial());

  void fetchProfileHeaders() async {
    final result = await repository.fetchProfileHeaders();
    result.fold(
      (failure) => emit(ProfileHeaderError()),
      (profileHeaders) => emit(
        ProfileHeadersLoaded(
          profileHeaders: profileHeaders,
        ),
      ),
    );
  }
}
