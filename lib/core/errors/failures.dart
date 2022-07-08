// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Failure {}

class AuthFailure implements Failure {
  final String message;

  const AuthFailure({required this.message});
}

class AppInfoFailure implements Failure {
  final String message;
  const AppInfoFailure({
    required this.message,
  });
}
