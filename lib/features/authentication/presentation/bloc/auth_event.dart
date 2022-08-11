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

class SendOtpEvent<ParameterType> extends AuthEvent {
  final ParameterType parameter;
  const SendOtpEvent({
    required this.parameter,
  });

  @override
  List<Object> get props => super.props..add(parameter as Object);
}

class RegisterEvent extends AuthEvent {
  final RegisterParameter registerParameter;
  const RegisterEvent({
    required this.registerParameter,
  });
  @override
  List<Object> get props => super.props..add(registerParameter);
}

class GoogleAuthEvent extends AuthEvent {
  const GoogleAuthEvent();
}

class FacebookAuthEvent extends AuthEvent {
  const FacebookAuthEvent();
}

class FinishUserGuideEvent extends AuthEvent {
  const FinishUserGuideEvent();
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  const ForgotPasswordEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object> get props => super.props..addAll([email,password]);
}

class LockAuthEvent extends AuthEvent {
  const LockAuthEvent();
}

class UnlockAuthEvent extends AuthEvent {
  const UnlockAuthEvent();
}
