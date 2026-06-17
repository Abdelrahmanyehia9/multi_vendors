import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/mixin/login_screen_mixin.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_header.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_social_login.dart';
import 'package:multi_vendor/features/authentication/view/widgets/login_form.dart';
import 'package:multi_vendor/features/authentication/view/widgets/toggle_singup_and_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoginScreenMixin {
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
              onSuccess: (_) => onLoginSuccess(),
              builder: (state) => AppButton(
                text: AppStrings.signIn.tr(),
                buttonSize: null,
                isLoading: state.isLoading,
                onPressed: onLogin,
              ),
            ),
            if (AppConfigs.authFormType == AuthFormType.emailAndPassword)
              const ToggleSignupAndLogin(),
              AppButton.text(
                style: TextStyles.bodyLarge.copyWith(
                  color: AppColors.secondary,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.secondary,
                ),
              text: AppStrings.continueAsGuest.tr(),
              onPressed: userCubit.loginAsGuest,
            ),
            const AuthSocialLogin(),
          ],
        ),
      ),
    );
  }
}
