import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import 'package:multi_vendor/features/authentication/view/widgets/password_validations_hint.dart';

import '../../../../core/widgets/app_text_field.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      spacing: 16.h,
      children:  [
        const AppTextField(
          hintText: "Enter your full name",
          headerText: "Full name",
          borderType:  AppBorderType.filled
          ,
        ),
        const EmailField(),
        const PhoneField(),
        const PasswordField(),
        const PasswordField(
          header: "Confirm password",
          hint: "Enter your confirm password",
        ),
        PasswordValidationBuilder(controller: TextEditingController(),)
      ],
    );
  }
}
