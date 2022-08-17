import 'package:email_validator/email_validator.dart';

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Email cannot be empty';
  } else if (!EmailValidator.validate(email)) {
    return 'Invalid email address.';
  }
  return null;
}
