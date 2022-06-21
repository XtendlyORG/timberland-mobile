abstract class Failure {}

class AuthFailure implements Failure {
  final String message;

  const AuthFailure({required this.message});
}
