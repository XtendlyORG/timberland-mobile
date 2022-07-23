String? validatePassword(String? password) {
  final numberRegex = RegExp(
    r"^(?=.*\d)",
  );
  final letterRegex = RegExp(
    r"^(?=.*[A-Za-z])",
  );
  if (password == null || password.isEmpty) {
    return 'Password cannot be empty';
  } else if (password.length < 6) {
    return 'Password must be atleast 6 characters.';
  } else if (!letterRegex.hasMatch(password)) {
    return 'Password should contain at least one letter';
  } else if (!numberRegex.hasMatch(password)) {
    return 'Password should contain at least one number';
  }
  return null;
}
