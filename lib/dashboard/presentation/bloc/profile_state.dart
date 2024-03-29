// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UpdatingProfile extends ProfileState {
  const UpdatingProfile();
}

class UpdatingUserDetail extends ProfileState {
  final int pageNum;
  final UpdateUserDetailsParams updatedUser;

  const UpdatingUserDetail({
    required this.pageNum,
    required this.updatedUser,
  });

  @override
  List<Object> get props => super.props..addAll([pageNum, updatedUser]);
}

class ProfileUpdateRequestSent extends ProfileState {
  final String loadingMessage;
  const ProfileUpdateRequestSent({
    required this.loadingMessage,
  });
  @override
  List<Object> get props => super.props..add(loadingMessage);
}

class ProfileUpdateError extends ProfileState {
  final String errorMessage;
  const ProfileUpdateError({
    required this.errorMessage,
  });
  @override
  List<Object> get props => super.props..addAll([errorMessage, DateTime.now()]);
}

class ProfileUpdated extends ProfileState {
  final User user;
  final String message;
  const ProfileUpdated({
    required this.user,
    required this.message,
  });
  @override
  List<Object> get props => super.props..addAll([user, message]);
}

class OTPToUpdateSent extends ProfileState {
  final String email;
  final String password;
  const OTPToUpdateSent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => super.props
    ..addAll([
      email,
      password,
      DateTime.now(),
    ]);
}

class ProfileOtpError extends ProfileState {
  final String email;
  final String errorMessage;
  final int? otpPenaltyDuration;
  const ProfileOtpError({
    required this.email,
    required this.errorMessage,
    this.otpPenaltyDuration,
  });

  @override
  List<Object> get props => super.props
    ..addAll([
      email,
      errorMessage,
      if (otpPenaltyDuration != null) otpPenaltyDuration!,
      DateTime.now(),
    ]);
}
