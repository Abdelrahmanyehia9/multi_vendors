import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/mixin/signup_screen_mixin.dart';
import 'package:multi_vendor/features/authentication/view/widgets/signup_form.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SignUpScreenMixin{
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Sign Up"),
      body: SingleChildScrollView(
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Form(
              key: formKey,
              child: SignupForm(
                onCountryChanged: (country) => selectedCountry = country,
                fullNameController: userName,
                emailController: email,
                passwordController: password,
                confirmPasswordController: passwordConfirm,
                phoneController: phone,
              ),
            ),
            BaseBlocConsumer(
              bloc: cubit,
              onFailure: onSignUpFailure,
              builder: (state) =>
                  AppButton(
                    isLoading: state.isLoading,
                    text: "Sign Up",
                    buttonSize: null,
                    onPressed: onSignUp,
                  ),
            ),
          ],
        ),



      ),
    );
  }

  Widget _buildHeader() =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          Text("Join us", style: TextStyles.labelLarge),
          Text(
            "Recommendations for your fashion collection to support your activities",
            style: TextStyles.captionMedium,
          ),
        ],
      );
}