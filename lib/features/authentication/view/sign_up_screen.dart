import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/data/model/auth_user_model.dart';
import 'package:multi_vendor/features/authentication/logic/sign_up_cubit.dart';
import 'package:multi_vendor/features/authentication/view/widgets/signup_form.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/widgets/app_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userName        = TextEditingController();
  final TextEditingController _email           = TextEditingController();
  final TextEditingController _password        = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();
  final TextEditingController _phone           = TextEditingController();
  final GlobalKey<FormState> formKey           = GlobalKey<FormState>();
  String _dialCode = "20";
  void onSignUp() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    context.read<SignupCubit>().signup(
      password: _password.text.trim(),
      user: AuthUserModel(
        email: _email.text.trim(),
        phone: "$_dialCode${_phone.text.trim()}",
        fullName: _userName.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Sign Up"),
      body: SingleChildScrollView(
        child: BaseBlocConsumer(
          bloc: context.read<SignupCubit>(),
          builder:(_)=> Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              Form(
                key: formKey,
                child: SignupForm(
                  onCountryChanged: (country) => _dialCode = country.dialCode,
                  fullNameController: _userName,
                  emailController: _email,
                  passwordController: _password,
                  confirmPasswordController: _passwordConfirm,
                  phoneController: _phone,
                ),
              ),
              AppButton(
                text: "Sign Up",
                buttonSize: null,
                onPressed: onSignUp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Column(
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

  @override
  void dispose() {
   final  controllers = [
      _userName,
      _email,
      _password,
      _passwordConfirm,
      _phone,
    ];
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }
}