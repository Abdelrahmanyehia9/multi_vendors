import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import '../../../../core/enum/login_providers.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/forget_password_button.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController ;
  final TextEditingController passwordController ;
  final TextEditingController phoneController ;
  final void Function(Country)? onCountryChanged ;
  const LoginForm({super.key
  , required this.emailController
  , required this.passwordController,
  this.onCountryChanged,
   required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children:  [
        if (AppConstants.authFormType == AuthFormType.emailAndPassword) ...[
          EmailField(
            controller: emailController,
          ),
          PasswordField(
            controller: passwordController,
          ),
          const ForgetPasswordButton(),
        ] else ...[
          PhoneField(
            onCountryChanged: onCountryChanged,
            controller: phoneController,
          ),
        ],
      ],
    );
  }
}

