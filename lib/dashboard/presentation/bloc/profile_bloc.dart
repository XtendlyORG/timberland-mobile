// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/dashboard/domain/params/update_user_detail.dart';
import 'package:timberland_biketrail/dashboard/domain/repository/profile_repository.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;
  ProfileBloc({
    required this.repository,
  }) : super(ProfileInitial()) {
    on<UpdateUserDetailEvent>((event, emit) {
      emit(UpdatingUserDetail(
        updatedUser: UpdateUserDetailsParams(
          firstName: event.user.firstName,
          middleName: event.user.middleName,
          lastName: event.user.lastName,
          mobileNumber: event.user.mobileNumber,
          address: event.user.address,
          bikeColor: event.user.bikeColor,
          bikeModel: event.user.bikeModel,
          bikeYear: event.user.bikeYear,
          birthday: event.user.birthday,
          bloodType: event.user.bloodType,
          emergencyContactInfo: event.user.emergencyContactInfo,
          gender: event.user.gender,
          profession: event.user.profession,
          profilePic: event.user.profilePic,
        ),
        pageNum: 1,
      ));
    });

    on<NavigateToNextPage>((event, emit) {
      emit(UpdatingUserDetail(
        updatedUser: event.updatedUser,
        pageNum: 2,
      ));
    });

    on<SubmitUpdateUserDetailRequestEvent>((event, emit) async {
      emit(
        const ProfileUpdateRequestSent(
          loadingMessage: 'Updating User Detail',
        ),
      );

      final result = await repository.updateUserDetail(
        event.updateProfileParams,
      );

      result.fold(
        (failure) {
          emit(
            ProfileUpdateError(errorMessage: failure.message),
          );
        },
        (user) {
          emit(ProfileUpdated(user: user));
          emit(ProfileInitial());
        },
      );
    });
    on<UpdateEmailRequest>((event, emit) async {
      final result = await repository.updateEmailRequest(
        event.email,
        event.password,
      );
      result.fold(
        (l) {
          emit(ProfileUpdateError(errorMessage: l.message));
        },
        (r) {
          emit(OTPToUpdateSent(email: event.email, password: event.password));
        },
      );
    });
    on<ResendEmailOTP>((event, emit) async {
      final result = await repository.resendEmailOtp(event.email);
      result.fold(
        (l) {
          emit(
            ProfileOtpError(
              email: event.email,
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          emit(
            OTPToUpdateSent(
              email: event.email,
              password: '',
            ),
          );
        },
      );
    });

    on<VerifyEmailUpdate>((event, emit) async {
      final result = await repository.verifyEmailUpdate(
        event.email,
        event.otp,
      );

      result.fold(
        (l) {
          emit(
            ProfileOtpError(
              email: event.email,
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          emit(
            ProfileUpdated(
              user: Session().currentUser!.copyWith(email: event.email),
            ),
          );
        },
      );
    });

    on<CancelUpdateRequest>((event, emit) {
      emit(ProfileInitial());
    });
  }
}
