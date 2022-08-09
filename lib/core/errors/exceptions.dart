// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthException implements Exception {
  final String? message;
  AuthException({
    this.message,
  });
}

class UnverifiedEmailException extends AuthException {
  UnverifiedEmailException({
    super.message,
  });
}

class AppInfoException implements Exception {
  final String? message;
  const AppInfoException({
    this.message,
  });
}

class TrailException implements Exception {
  final String? message;
  const TrailException({
    this.message,
  });
}
