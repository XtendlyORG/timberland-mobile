// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthException implements Exception {
  final String? message;
  final int? penaltyDuration;
  AuthException({
    this.message,
    this.penaltyDuration,
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

class ProfileException implements Exception {
  final String? message;
  final int? penaltyDuration;
  const ProfileException({
    this.message,
    this.penaltyDuration,
  });
}

class HistoryException implements Exception {
  final String? message;
  const HistoryException({
    this.message,
  });
}

class BookingException implements Exception {
  final String? message;
  const BookingException({
    this.message,
  });
}

class DuplicateBookingException implements BookingException {
  @override
  final String? message;
  const DuplicateBookingException({
    this.message,
  });
}
