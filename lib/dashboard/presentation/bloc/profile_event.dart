// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserDetailEvent extends ProfileEvent {
  final UpdateUserDetailsParams user;
  const UpdateUserDetailEvent({
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

class SubmitUpdateUserDetailRequestEvent extends ProfileEvent {
  final UpdateUserDetailsParams updateProfileParams;
  const SubmitUpdateUserDetailRequestEvent({
    required this.updateProfileParams,
  });
  @override
  List<Object> get props => super.props..add(updateProfileParams);
}

class UpdateEmailRequest extends ProfileEvent {
  final String email;
  final String password;
  const UpdateEmailRequest({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => super.props..addAll([email, password]);
}

class ResendEmailOTP extends ProfileEvent {
  final String email;
  const ResendEmailOTP({
    required this.email,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      email,
      DateTime.now(),
    ]);
}

class VerifyEmailUpdate extends ProfileEvent {
  final String email;

  final String otp;
  const VerifyEmailUpdate({
    required this.email,
    required this.otp,
  });
}
