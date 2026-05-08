import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

class AppValidation {
  AppValidation._();

  static String? _checkNullOrEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName.tr()} ${AppStrings.cannotBeEmpty.tr()}';
    }
    return null;
  }
  static String? validateRequired(String? value, {String fieldName = AppStrings.thisField}) {
    return _checkNullOrEmpty(value, fieldName);
  }
  static String? validatePassword(String? password) {
    final emptyCheck = _checkNullOrEmpty(password, AppStrings.password);
    if (emptyCheck != null) return emptyCheck;

    if (!AppRegEX.isValidPassword(password!)) {
      return AppStrings.passwordTooWeak.tr();
    }
    return null;
  }
  static String? validatePasswordConfirmation(String? password, String? confirmPassword) {
    final confirmCheck = _checkNullOrEmpty(confirmPassword, AppStrings.confirmPassword);
    if (confirmCheck != null) return confirmCheck;

    if (password != confirmPassword) {
      return AppStrings.passwordsDoNotMatch.tr();
    }
    return null;
  }
  static String? validateEmail(String? email, bool? nullable) {
    if (nullable == true && email.isNullOrEmpty) return null;
    final emptyCheck = _checkNullOrEmpty(email, AppStrings.email);
    if (emptyCheck != null) return emptyCheck;

    final normalizedEmail = email!.trim().toLowerCase();
    if (!AppRegEX.isValidEmail(normalizedEmail)) {
      return AppStrings.enterInvalidEmail.tr();
    }
    return null;
  }
}

  class AppRegEX {
  AppRegEX._();

  static bool isValidUsername(String username) {
  return RegExp(r'^[a-zA-Z0-9_]{3,}$').hasMatch(username);
  }
  static bool isValidEmail(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email);
  }

  static bool hasLowerCase(String password) {
  return RegExp(r'^(?=.*[a-z])').hasMatch(password);
  }

  static bool hasUpperCase(String password) {
  return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
  return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasSpecialCharacter(String password) {
  return RegExp(r'^(?=.*?[#?!@$%^&*-])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
  return RegExp(r'^(?=.{8,})').hasMatch(password);
  }

  static bool isValidPassword(String password) {
  return /* hasLowerCase(password) &&
        hasUpperCase(password) &&
        hasNumber(password) &&
        hasSpecialCharacter(password) && */ hasMinLength(password);
  }


}


