String? passwordValidator(String? password, {bool acceptEmpty = false}) {
  final numberRegex = RegExp(
    r"^(?=.*\d)",
  );
  final uppercaseRegex = RegExp(
    r'(?=.*[A-Z])',
  );
  if (password == null || password.isEmpty) {
    if (acceptEmpty) return null;
    return 'Please enter your password';
  } else if (!uppercaseRegex.hasMatch(password)) {
    return 'Password should contain at least one uppercase letter';
  } else if (!numberRegex.hasMatch(password)) {
    return 'Password should contain at least one number';
  } else if (password.length < 6) {
    return 'Password must be atleast 6 characters.';
  }
  return null;
}

String? passwordValidator2(String? password, {bool acceptEmpty = false}) {
  final numberRegex = RegExp(
    r"^(?=.*\d)",
  );
  final uppercaseRegex = RegExp(
    r'(?=.*[A-Z])',
  );

  String errorMessage = '\n';
  if (password == null || password.isEmpty) {
    if (acceptEmpty) return null;
    return 'Please enter your password';
  }
  if (password.length < 6) {
    errorMessage += '- at least 6 characters.\n';
  }
  if (!uppercaseRegex.hasMatch(password)) {
    errorMessage += '- at least one uppercase letter\n';
  }
  if (!numberRegex.hasMatch(password)) {
    errorMessage += '- at least one number\n';
  }

  return errorMessage.trim().isEmpty
      ? null
      : 'Password should contain: \n${errorMessage.trim()}';
}
