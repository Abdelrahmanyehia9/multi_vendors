import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/features/authentication/logic/otp_confirm_cubit.dart';
import 'package:multi_vendor/features/authentication/view/otp_confirm_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
mixin OtpConfirmScreenMixin on State<OtpConfirmScreen> {

  final PinInputController controller = PinInputController();
  OtpConfirmCubit get cubit => context.read<OtpConfirmCubit>();



  Future<void> onConfirm() async{
    cubit.confirmOtp(otp: controller.text, provider: widget.phoneNumber);
  }
  void onConfirmFailure(AppException e) {
    context.errorBar(message: e.message);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}