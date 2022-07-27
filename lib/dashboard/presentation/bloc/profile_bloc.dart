import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../features/authentication/domain/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) {
      emit(UpdatingProfile(
        user: event.user,
        pageNum: 1,
      ));
    });

    on<NavigateToNextPage>((event, emit) {
      log('test');
      emit(UpdatingProfile(
        user: event.user,
        pageNum: 2,
      ));
    });

    on<SubmitUpdateRequestEvent>(
      (event, emit) {
        emit(ProfileUpdated());
      },
    );
  }
}
