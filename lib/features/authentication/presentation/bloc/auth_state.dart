// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState {
  const UnAuthenticated();
}

class OtpSent extends AuthState {
  final RegisterParameter registerParameter;
  const OtpSent({
    required this.registerParameter,
  });
  @override
  List<Object> get props => super.props..add(registerParameter);
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
}

class AuthError extends AuthState {
  final String errorMessage;
  const AuthError({
    required this.errorMessage,
  });
  @override
  List<Object> get props => super.props..add(errorMessage);
}

class AuthLoading extends AuthState {
  final String loadingMessage;
  const AuthLoading({
    required this.loadingMessage,
  });

  @override
  List<Object> get props => super.props..add(loadingMessage);
}
