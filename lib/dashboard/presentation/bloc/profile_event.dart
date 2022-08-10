// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateUserDetailsParams user;
  const UpdateProfileEvent({
    required this.user,
  });
}

class CancelUpdateRequest extends ProfileEvent {
  const CancelUpdateRequest();
}

class NavigateToNextPage extends ProfileEvent {
  final UpdateUserDetailsParams updatedUser;

  const NavigateToNextPage({
    required this.updatedUser,
  });
}

class SubmitUpdateRequestEvent extends ProfileEvent {
  final UpdateUserDetailsParams updateProfileParams;
  const SubmitUpdateRequestEvent({
    required this.updateProfileParams,
  });
  @override
  List<Object> get props => super.props..add(updateProfileParams);
}

class SubmitUpdateOtp extends ProfileEvent {
  final String email;
  final String password;
  final String otp;
  const SubmitUpdateOtp({
    required this.email,
    required this.password,
    required this.otp,
  });
}
