import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/helper/app_validation.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/features/authentication/view/widgets/forget_password_button.dart';

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
           ForgetPasswordButton(
             email: emailController.text,
           ),
        ] else ...[
          PhoneField(
          validator:(p)=> AppValidation.validateRequired(p?.number,fieldName: AppStrings.phoneNumber.tr() ),
            onCountryChanged: onCountryChanged,
            controller: phoneController,
          ),
        ],
      ],
    );
  }
}

