import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import 'package:multi_vendor/features/authentication/view/widgets/password_validations_hint.dart';

import '../../../../core/utils/helper/app_validation.dart';
import '../../../../core/widgets/app_text_field.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final void Function(Country)? onCountryChanged;
  const SignupForm({super.key,
    required this.fullNameController,
    required this.emailController,
    required this.phoneController,
    required this.onCountryChanged,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    return  Column(
      spacing: 16.h,
      children:  [
         AppTextField(
          hintText: "Enter your full name",
          headerText: "Full name",
          borderType:  AppBorderType.filled,
          controller: fullNameController,
        ),
         EmailField(controller: emailController,),
         PhoneField(controller: phoneController,
         onCountryChanged: onCountryChanged,
         ),
         PasswordField(controller: passwordController,),
         PasswordField(
          header: "Confirm password",
          hint: "Enter your confirm password",
           controller: confirmPasswordController,
           validator: (val)=>AppValidation.validatePasswordConfirmation(passwordController.text, val),
        ),
        PasswordValidationBuilder(controller: passwordController,)
      ],
    );
  }
}
