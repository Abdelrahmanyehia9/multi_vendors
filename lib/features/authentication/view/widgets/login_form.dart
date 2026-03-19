import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import '../../../../core/enum/login_providers.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/forget_password_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      children: const [
        if (AppConstants.authFormType == AuthFormType.emailAndPassword) ...[
          EmailField(),
          PasswordField(),
          ForgetPasswordButton(),
        ] else ...[
          PhoneField(),
        ],
      ],
    );
  }
}

