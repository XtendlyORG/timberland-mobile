// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class Failure {}

class AuthFailure implements Failure {
  final String message;
  final int? penaltyDuration;
  const AuthFailure({
    required this.message,
    this.penaltyDuration,
  });
}

class UnverifiedEmailFailure extends AuthFailure {
  const UnverifiedEmailFailure({required super.message});
}

class AppInfoFailure implements Failure {
  final String message;
  const AppInfoFailure({
    required this.message,
  });
}

class TrailFailure implements Failure {
  final String message;
  const TrailFailure({
    required this.message,
  });
}

class ProfileFailure implements Failure {
  final String message;
  final int? penaltyDuration;
  const ProfileFailure({
    required this.message,
    this.penaltyDuration,
  });
}

class HistoryFailure implements Failure {
  final String message;
  const HistoryFailure({
    required this.message,
  });
}

class BookingFailure implements Failure {
  final String message;
  const BookingFailure({
    required this.message,
  });
}

class DuplicateBookingFailure implements BookingFailure {
  @override
  final String message;
  const DuplicateBookingFailure({
    required this.message,
  });
}

class EmergencyFailure implements Failure {
  final String message;
  const EmergencyFailure({
    required this.message,
  });
}
