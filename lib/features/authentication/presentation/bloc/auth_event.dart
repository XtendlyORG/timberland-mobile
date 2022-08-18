// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class UpdateUser extends AuthEvent {
  final User newUser;
  const UpdateUser({
    required this.newUser,
  });
  @override
  List<Object> get props => super.props..add(newUser);
}

class FetchUserEvent extends AuthEvent {
  const FetchUserEvent();
}

class LoginEvent extends AuthEvent {
  final LoginParameter loginParameter;
  const LoginEvent({
    required this.loginParameter,
  });

  @override
  List<Object> get props => super.props..add(loginParameter);
}

class RequestRegisterEvent extends AuthEvent {
  final RegisterParameter parameter;
  const RequestRegisterEvent({
    required this.parameter,
  });

  @override
  List<Object> get props => super.props..add(parameter);
}

class ResendOTPEvent<ParameterType> extends AuthEvent {
  final ParameterType parameter;
  const ResendOTPEvent({
    required this.parameter,
  });
  String get email {
    if (parameter is RegisterParameter) {
      return (parameter as RegisterParameter).email;
    } else if (parameter is VerifyOTPParameter) {
      return (parameter as VerifyOTPParameter).email;
    } else if (parameter is LoginParameter) {
      return (parameter as LoginParameter).email;
    } else if (parameter is String) {
      return parameter as String;
    }
    throw Exception(
        'Invalid parameter type in SendOTPEvent: ${parameter.runtimeType}');
  }

  @override
  List<Object> get props => super.props..add(parameter as Object);
}

abstract class VerifyOtpEvent<ParameterType> extends AuthEvent {
  final ParameterType parameter;
  final String otp;
  const VerifyOtpEvent({
    required this.parameter,
    required this.otp,
  });
}

class VerifyRegisterEvent extends VerifyOtpEvent<RegisterParameter> {
  const VerifyRegisterEvent({
    required super.parameter,
    required super.otp,
  });

  @override
  List<Object> get props => super.props..addAll([parameter, otp]);
}

class VerifyForgotPasswordEvent extends VerifyOtpEvent<String> {
  const VerifyForgotPasswordEvent({
    required super.parameter,
    required super.otp,
  });

  @override
  List<Object> get props => super.props..addAll([parameter, otp]);
}

class GoogleAuthEvent extends AuthEvent {
  const GoogleAuthEvent();
}

class FacebookAuthEvent extends AuthEvent {
  const FacebookAuthEvent();
}

class FinishUserGuideEvent extends AuthEvent {
  final bool skipBooking;
  const FinishUserGuideEvent({
    this.skipBooking = false,
  });

  @override
  List<Object> get props => super.props..add(skipBooking);
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class LockAuthEvent extends AuthEvent {
  const LockAuthEvent();
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  const ForgotPasswordEvent({
    required this.email,
  });
  @override
  List<Object> get props => super.props..add(email);
}

class ResetPasswordEvent extends AuthEvent {
  final ResetPasswordParameter resetPasswordParameter;
  const ResetPasswordEvent({
    required this.resetPasswordParameter,
  });
  @override
  List<Object> get props => super.props..add(resetPasswordParameter);
}

class UnlockAuthEvent extends AuthEvent {
  const UnlockAuthEvent();
}
