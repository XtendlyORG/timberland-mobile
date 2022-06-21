// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  const Authenticated({
    required this.user,
  });
  @override
  List<Object> get props => super.props..add(user);
}
