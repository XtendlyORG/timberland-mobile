import 'package:equatable/equatable.dart';

class LoginParameter extends Equatable {
  //TODO: Fields may change
  final String email;
  final String password;
  const LoginParameter({
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
