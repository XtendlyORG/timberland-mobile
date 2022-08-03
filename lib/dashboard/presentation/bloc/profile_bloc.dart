// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/update_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
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
      (event, emit) {
        emit(ProfileUpdated());
      },
    );
    on<CancelUpdateRequest>((event, emit) {
      emit(ProfileInitial());
    });
  }
}
