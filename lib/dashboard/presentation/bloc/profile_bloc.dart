// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/update_profile.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository repository;
  ProfileBloc({
    required this.repository,
  }) : super(ProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) {
      emit(UpdatingProfile(
        updatedUser: UpdateProfileParams(
          firstName: event.user.firstName,
          middleName: event.user.middleName,
          lastName: event.user.lastName,
          email: event.user.email,
          mobileNumber: event.user.mobileNumber,
          address: event.user.address,
          bikeColor: event.user.bikeColor,
          bikeModel: event.user.bikeModel,
          bikeYear: event.user.bikeYear,
          birthDay: event.user.birthDay,
          bloodType: event.user.bloodType,
          emergencyContactInfo: event.user.emergencyContactInfo,
          gender: event.user.gender,
          password: event.user.password,
          profession: event.user.profession,
          profilePic: event.user.profilePic,
        ),
        pageNum: 1,
      ));
    });

    on<NavigateToNextPage>((event, emit) {
      emit(UpdatingProfile(
        updatedUser: event.updatedUser,
        pageNum: 2,
      ));
    });

    on<SubmitUpdateRequestEvent>(
      (event, emit) async {
        emit(
          const ProfileUpdateRequestSent(
            loadingMessage: 'Updating your profile',
          ),
        );

        final result = await repository.updateProfile(
          event.updateProfileParams,
        );

        result.fold(
          (failure) {
            emit(
              ProfileUpdateError(
                errorMessage: failure.message,
              ),
            );
            emit(ProfileInitial());
          },
          (user) {
            emit(
              ProfileUpdated(user: user),
            );
            emit(ProfileInitial());
          },
        );
      },
    );
    on<CancelUpdateRequest>((event, emit) {
      emit(ProfileInitial());
    });
  }
}
