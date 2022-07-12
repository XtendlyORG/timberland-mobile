String? validateEmail(String? email) {
  final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  if (email == null || email.isEmpty) {
    return 'Email cannot be empty';
  } else if (!regex.hasMatch(email)) {
    return 'Invalid email address.';
  }
  return null;
}
