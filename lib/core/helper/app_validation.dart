class AppValidation {
  AppValidation._();

  static String? _checkNullOrEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }
  static String? validateRequired(String? value, {String fieldName = 'This field'}) {
    return _checkNullOrEmpty(value, fieldName);
  }
  static String? validatePassword(String? password) {
    final emptyCheck = _checkNullOrEmpty(password, 'Password');
    if (emptyCheck != null) return emptyCheck;

    if (!AppRegex.isValidPassword(password!)) {
      return 'Password is too weak.';
    }
    return null;
  }
  static String? validatePasswordConfirmation(String? password, String? confirmPassword) {
    final confirmCheck = _checkNullOrEmpty(confirmPassword, 'Confirm password');
    if (confirmCheck != null) return confirmCheck;

    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }
    return null;
  }
  static String? validateEmail(String? email) {
    final emptyCheck = _checkNullOrEmpty(email, 'Email address');
    if (emptyCheck != null) return emptyCheck;

    final normalizedEmail = email!.trim().toLowerCase();
    if (!AppRegex.isValidEmail(normalizedEmail)) {
      return 'Invalid email address.';
    }
    return null;
  }
}
class AppRegex {
  AppRegex._();

  static bool isValidUsername(String username) =>
      RegExp(r'^[a-zA-Z0-9_]{3,}$').hasMatch(username);
  static bool isValidPassword(String password) =>
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#?!@$%^&*-]).{8,}$')
          .hasMatch(password);
  static bool isValidEmail(String email) =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(email);
}

