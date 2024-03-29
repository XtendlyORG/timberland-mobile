// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState {
  final bool keepCurrentUser;
  const UnAuthenticated({
    this.keepCurrentUser = false,
  });
  @override
  List<Object> get props => super.props..add(keepCurrentUser);
}

class OtpSent<ParameterType> extends AuthState {
  final ParameterType parameter;
  final String message;
  final bool? hasError;
  const OtpSent({
    this.hasError,
    required this.parameter,
    required this.message,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      parameter as Object,
      message,
    ]);
}

class OtpResent<ParameterType> extends OtpSent {
  const OtpResent({
    required super.parameter,
    required super.message,
  });
}

class Authenticated extends AuthState {
  final String message;
  final bool firstTimeUser;
  final User user;
  const Authenticated({
    required this.message,
    this.firstTimeUser = false,
    required this.user,
  });
  @override
  List<Object> get props => super.props..addAll([user, message, firstTimeUser]);

  Authenticated copyWith({
    String? message,
    bool? firstTimeUser,
    User? user,
  }) {
    return Authenticated(
      message: message ?? this.message,
      firstTimeUser: firstTimeUser ?? this.firstTimeUser,
      user: user ?? this.user,
    );
  }
}

class UserGuideFinished extends Authenticated {
  const UserGuideFinished({
    required super.message,
    required super.user,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      message,
      user,
    ]);
}

class AuthError<ParameterType> extends AuthState {
  final String errorMessage;
  final ParameterType? parameter;
  final int? penaltyDuration;
  const AuthError({
    required this.errorMessage,
    this.parameter,
    this.penaltyDuration,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      errorMessage,
      if (parameter != null) parameter!,
      if (penaltyDuration != null) penaltyDuration!,
      DateTime.now(),
    ]);
}

class AuthLocked extends AuthState {
  final DateTime lockUntil;
  const AuthLocked({
    required this.lockUntil,
  });
  @override
  List<Object> get props => super.props..add(lockUntil);
}

class AuthLoading extends AuthState {
  final String loadingMessage;
  const AuthLoading({
    required this.loadingMessage,
  });

  @override
  List<Object> get props => super.props..add(loadingMessage);
}

class EmailVerified extends AuthState {
  const EmailVerified();
}

class SettingNewPassword extends AuthState {
  final String email;

  const SettingNewPassword({
    required this.email,
  });
  @override
  List<Object> get props => super.props..addAll([email]);
}

class PasswordUpdated extends AuthState {
  const PasswordUpdated();
}
