import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/features/authentication/view/widgets/password_validations_hint.dart';

import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart' show PasswordField;

class ChangePasswordForm extends StatelessWidget {
  final TextEditingController passwordController ;
  final TextEditingController passwordConfirmController ;
  const ChangePasswordForm({super.key, required this.passwordController, required this.passwordConfirmController});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: [
        PasswordField(controller: passwordController),
        PasswordField.confirm(
          password: passwordController.text,
          controller: passwordConfirmController,
        ),
        PasswordValidationBuilder(controller: passwordController),
      ],
    );
  }
}

