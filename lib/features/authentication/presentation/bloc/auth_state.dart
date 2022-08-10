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

class OtpSent extends AuthState {
  final RegisterParameter registerParameter;
  final String message;
  const OtpSent({
    required this.registerParameter,
    required this.message,
  });
  @override
  List<Object> get props => super.props
    ..addAll([
      registerParameter,
      message,
    ]);
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

class AuthError extends AuthState {
  final String errorMessage;
  final RegisterParameter? registerParameter;
  const AuthError({
    required this.errorMessage,
    this.registerParameter,
  });
  @override
  List<Object> get props => super.props..add(errorMessage);
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
