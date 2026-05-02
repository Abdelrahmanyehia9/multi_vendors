import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/features/authentication/logic/sign_up_cubit.dart';
import 'package:multi_vendor/features/authentication/view/sign_up_screen.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';

mixin SignUpScreenMixin on State<SignUpScreen> {

  final TextEditingController userName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SignupCubit get cubit => context.read<SignupCubit>();
  Country selectedCountry = userCubit.user?.country ?? AppConstants.initialCountry;

  void onSignUp() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    cubit.signup(
      password: password.text.trim(),
      user: UserModel(
        email: email.text.trim(),
        phone: phone.text.isNullOrEmpty? null : phone.text.trim(),
        fullName: userName.text.trim(),
        country: selectedCountry,
      ),
    );
  }
  void onSignUpFailure(AppException e) {
    context.errorBar(message: e.message);
  }
  @override
  void dispose() {
    final controllers = [
      userName,
      email,
      password,
      passwordConfirm,
      phone,
    ];
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

}