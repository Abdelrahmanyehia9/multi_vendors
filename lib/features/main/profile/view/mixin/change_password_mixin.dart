// ignore_for_file: unused_import

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/main/profile/logic/edit_password_cubit.dart';
import 'package:multi_vendor/features/main/profile/view/change_password_screen.dart';
import 'package:flutter/material.dart';
mixin ChangePasswordMixin on State<ChangePasswordScreen>{
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  EditPasswordCubit get cubit => context.read<EditPasswordCubit>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future<void> onChangePassword() async {
    if (!formKey.currentState!.validate()) return;
    cubit.editPassword(passwordController.text);
  }

  void onChangePasswordError(AppException e) {
    context.errorBar(message: e.message);
  }

  void onChangePasswordSuccess() {
    context.successBar(message: AppStrings.passwordChangedSuccessfully);
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}