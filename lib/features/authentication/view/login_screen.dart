import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_header.dart';
import 'package:multi_vendor/features/authentication/view/widgets/login_form.dart';
import 'package:multi_vendor/features/authentication/view/widgets/toggle_singup_and_login.dart';

import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/authentication/logic/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phone = TextEditingController();
  LoginCubit get _cubit => context.read<LoginCubit>();
  Country selectedCountry = AppConstants.initialCountry;
  void onLogin() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (AppConstants.authFormType == AuthFormType.emailAndPassword) {
      _cubit.login(email: _email.text.trim(), password: _password.text.trim());
      return;
    }
    onLoginWithMobile();
  }
  void onLoginWithMobile() {
    _cubit.loginWithMobile(country: selectedCountry, mobile: _phone.text);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          children: [
            const AuthHeader(),
            Form(
              key: _formKey,
              child: LoginForm(
                onCountryChanged: (country) => selectedCountry = country,
                emailController: _email,
                passwordController: _password,
                phoneController: _phone,
              ),
            ),
            BaseBlocConsumer(
              bloc: _cubit,
              onFailure: (e) => context.errorBar(message: e.message),
              onSuccess: (e) {
                if (AppConstants.authFormType == AuthFormType.mobile) {
                  context.pushNamed(Routes.otp, arguments: selectedCountry.dialCode+_phone.text);
                }
              },
              builder: (state) => AppButton(
                text: "Sign in",
                buttonSize: null,
                isLoading: state.isLoading,
                onPressed: onLogin,
              ),
            ),
            if (AppConstants.authFormType == AuthFormType.emailAndPassword)
              const ToggleSignupAndLogin(),
            AppButton.text(text: "Continue as Guest", onPressed: userCubit.loginAsGuest,),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _phone.dispose();
    super.dispose();
  }
}
