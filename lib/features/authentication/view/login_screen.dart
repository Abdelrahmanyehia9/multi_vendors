import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_header.dart';
import 'package:multi_vendor/features/authentication/view/widgets/login_form.dart';
import 'package:multi_vendor/features/authentication/view/widgets/toggle_singup_and_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BaseScaffold(
        body: SingleChildScrollView(
          child: Column(
            spacing: 16.h,
              children: const [
                AuthHeader(),
                LoginForm(),
                AppButton(text: "Sign in", buttonSize: null,),
                if(AppConstants.authFormType == AuthFormType.emailAndPassword)
                ToggleSignupAndLogin(),
              ]
          ),
        )
    );
  }
}



