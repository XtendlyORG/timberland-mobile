

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookingResponse {
  final bool isFree;
  final String message;
  final String? redirectUrl;
  const BookingResponse({
    required this.isFree,
    required this.message,
    this.redirectUrl,
  });

  factory BookingResponse.fromMap(Map<String, dynamic> map) {
    return BookingResponse(
      isFree: (map['message'] as String).contains('Free'),
      message: map['message'] as String,
      redirectUrl: map['redirectUrl'] as String?,
    );
  }
}
