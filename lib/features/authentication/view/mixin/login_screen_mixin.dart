import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/features/authentication/logic/login_cubit.dart';
import 'package:multi_vendor/features/authentication/view/login_screen.dart';
import 'package:flutter/material.dart';

mixin LoginScreenMixin on State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phone = TextEditingController();
  LoginCubit get cubit => context.read<LoginCubit>();
  Country selectedCountry = AppConstants.initialCountry;
  void onLogin() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (AppConstants.authFormType == AuthFormType.emailAndPassword) {
      cubit.login(email: email.text.trim(), password: password.text.trim());
      return;
    }
    onLoginWithMobile();
  }
  void onLoginWithMobile() {
     cubit.loginWithMobile(country: selectedCountry, mobile: phone.text);
  }
  void onLoginSuccess() {
    if (AppConstants.authFormType == AuthFormType.mobile) {
      context.pushNamed(Routes.otp, arguments: selectedCountry.dialCode+phone.text);
    }
  }
  void onLoginFailure(AppException e) {
    context.errorBar(message: e.message);
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    phone.dispose();
    super.dispose();
  }

}