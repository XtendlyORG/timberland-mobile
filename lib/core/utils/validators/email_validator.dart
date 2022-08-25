import 'package:email_validator/email_validator.dart';

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Please enter your email';
  } else if (!EmailValidator.validate(email)) {
    return "Invalid email. Please enter your email  in the format: 'name@example.com'";
  }
  return null;
}
