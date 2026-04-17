import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/models/user_model.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/logic/sign_up_cubit.dart';
import 'package:multi_vendor/features/authentication/view/widgets/signup_form.dart';
import '../../../core/theme/text_styles.dart';
import '../../../core/utils/app_constants.dart';
import '../../../core/widgets/app_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SignupCubit get _cubit => context.read<SignupCubit>();
  Country _selectedCountry = userCubit.user?.country ?? AppConstants.initialCountry;

  void onSignUp() {
    if (!(formKey.currentState?.validate() ?? false)) return;
    _cubit.signup(
      password: _password.text.trim(),
      user: UserModel(
        email: _email.text.trim(),
        phone: _phone.text.isNullOrEmpty? null : _phone.text.trim(),
        fullName: _userName.text.trim(),
        country: _selectedCountry,
      ),
    );
  }

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
                onCountryChanged: (country) => _selectedCountry = country,
                fullNameController: _userName,
                emailController: _email,
                passwordController: _password,
                confirmPasswordController: _passwordConfirm,
                phoneController: _phone,
              ),
            ),
            BaseBlocConsumer(
              bloc: _cubit,
              onFailure: (e) => context.errorBar(message: e.message),
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

  @override
  void dispose() {
    final controllers = [
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