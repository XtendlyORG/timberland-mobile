// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginParameter loginParameter;
  const LoginEvent({
    required this.loginParameter,
  });

  @override
  List<Object> get props => super.props..add(loginParameter);
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

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}
