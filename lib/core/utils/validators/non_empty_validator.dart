String? nonEmptyValidator(
  String? val, {
  String errorMessage = 'Field can not be empty',
}) {
  if (val == null || val.isEmpty) {
    return errorMessage;
  }
  return null;
}
