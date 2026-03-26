import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_header.dart';
import 'package:multi_vendor/features/authentication/view/widgets/login_form.dart';
import 'package:multi_vendor/features/authentication/view/widgets/toggle_singup_and_login.dart';

import '../../../core/routes/routes.dart';
import '../logic/login_cubit.dart';

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
  String _dialCode = AppConstants.initialCountry.dialCode;
  String get completeNumber => _dialCode + _phone.text.trim();
  void onLogin() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (AppConstants.authFormType == AuthFormType.emailAndPassword) {
      _cubit.login(email: _email.text.trim(), password: _password.text.trim());
      return;
    }
    onLoginWithMobile();
  }

  void onLoginWithMobile() {
    _cubit.loginWithMobile(mobile: completeNumber);
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
                onCountryChanged: (country) => _dialCode = country.dialCode,
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
                  context.pushNamed(Routes.otp, arguments: completeNumber);
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
