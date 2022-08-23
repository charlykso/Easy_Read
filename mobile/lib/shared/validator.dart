class Validator {
  // Valid field patterns
  final RegExp _validName =
          RegExp(r"^[a-z]{2,}[-\'\.]?$", caseSensitive: false),
      _validEmail = RegExp(
          r"^[a-z0-9_]+([\.-]?[a-z0-9_]+)*@[a-z0-9_]+([\.-]?[a-z0-9_]+){2,63}(\.[a-z0-9_]{2,3})+$"),
      _validPhoneNumber = RegExp(r"^\+[0-9]{13,14}$");

  String? validateName(String? value) =>
      _validName.hasMatch(value!) ? null : 'Invalid name';

  String? validateEmail(String? value) =>
      _validEmail.hasMatch(value!) ? null : 'Invalid email address';

  String? validatePhoneNumber(String? value) =>
      _validPhoneNumber.hasMatch(value!) ? null : 'Invalid phone number';

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    } else if (value.length <= 6) {
      return 'Must be at least 6 characters';
    } else if (!value.contains(RegExp(r"[A-Z]"))) {
      return 'Must contain at least one uppercase letter';
    } else if (!value.contains(RegExp(r"[0-9]"))) {
      return 'Must contain at least one number';
    }

    return null;
  }
}
