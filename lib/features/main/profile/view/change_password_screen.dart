import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/profile/logic/edit_password_cubit.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../../../authentication/view/widgets/forget_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  EditPasswordCubit get cubit => context.read<EditPasswordCubit>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> onChangePassword() async {
    if (!_formKey.currentState!.validate()) return;
     cubit.editPassword(_passwordController.text);
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Change Password"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ChangePasswordForm(passwordController: _passwordController, passwordConfirmController: _confirmPasswordController),
              BaseBlocConsumer(
                bloc: cubit,
                onFailure: (e)=>context.errorBar(message :e.message),
                onSuccess: (_)=>context.successBar(message :"Password changed successfully"),
                builder: (s) => AppButton(
                  text: "Change Password",
                  isLoading: s.isLoading,
                  buttonSize: null,
                  onPressed: onChangePassword,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}


