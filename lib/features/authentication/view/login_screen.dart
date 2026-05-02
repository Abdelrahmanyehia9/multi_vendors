import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/mixin/login_screen_mixin.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_header.dart';
import 'package:multi_vendor/features/authentication/view/widgets/login_form.dart';
import 'package:multi_vendor/features/authentication/view/widgets/toggle_singup_and_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> with LoginScreenMixin{
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          children: [
            const AuthHeader(),
            Form(
              key: formKey,
              child: LoginForm(
                onCountryChanged: (country) => selectedCountry = country,
                emailController: email,
                passwordController: password,
                phoneController: phone,
              ),
            ),
            BaseBlocConsumer(
              bloc: cubit,
              onFailure: onLoginFailure,
              onSuccess:(_)=> onLoginSuccess(),
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

}
