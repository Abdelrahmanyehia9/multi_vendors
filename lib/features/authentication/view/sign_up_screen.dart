import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/widgets/signup_form.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Sign Up",),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             _buildHeader(),
            const SignupForm(),
            const AppButton(
              text: "Sign Up",
              buttonSize: null,

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader()=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 8.h,
    children: [
      Text(
        "Join us",
        style: TextStyles.labelLarge,
      ),
      Text(
        "Recommendations for your fashion collection to support your activities",
        style: TextStyles.captionMedium,
      ),
    ],
  );
}
