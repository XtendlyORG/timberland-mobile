// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthException implements Exception {
  final String? message;
  AuthException({
    this.message,
  });
}

class AppInfoException implements AuthException {
  @override
  final String? message;
  const AppInfoException({
    this.message,
  });
}
