String? validatePassword(String? password, {bool acceptEmpty = false}) {
  final numberRegex = RegExp(
    r"^(?=.*\d)",
  );
  final uppercaseRegex = RegExp(
    r'(?=.*[A-Z])',
  );
  if (password == null || password.isEmpty) {
    if (acceptEmpty) return null;
    return 'Password cannot be empty';
  } else if (!uppercaseRegex.hasMatch(password)) {
    return 'Password should contain at least one uppercase letter';
  } else if (!numberRegex.hasMatch(password)) {
    return 'Password should contain at least one number';
  } else if (password.length < 6) {
    return 'Password must be atleast 6 characters.';
  }
  return null;
}
