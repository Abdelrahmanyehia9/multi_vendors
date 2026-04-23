import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import 'package:multi_vendor/features/authentication/view/widgets/otp_cold_down.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/theme/text_styles.dart';
import '../logic/otp_confirm_cubit.dart';

class OtpConfirmScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpConfirmScreen({super.key, required this.phoneNumber});

  @override
  State<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen> {
  final PinInputController _controller = PinInputController();
  OtpConfirmCubit get _cubit => context.read<OtpConfirmCubit>();



  Future<void> _onConfirm() async{
    _cubit.confirmOtp(otp: _controller.text, provider: widget.phoneNumber);
  }


  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 8.h,
          children: [
            SvgPicture.asset(
              width: 200.w,
              height: 200.h,
              AppAssets.otpIllustration,
            ),
            Gap.medium(),
            Text(
              "Confirm your number",
              textAlign: TextAlign.center,
              style: TextStyles.headline3,
            ),
            Text(
              "Please enter the 6-digit code sent to your number ${widget.phoneNumber} to complete the verification process.",
              textAlign: TextAlign.center,
              style: TextStyles.bodyMedium.copyWith(
                color: context.colors.surfaceContainer,
              ),
            ),
            Gap.small(),
            PinCode(controller: _controller, onComplete: (_)=>_onConfirm(),),
            const OtpColdDown(),
            Gap.small(),
            BaseBlocConsumer(
              bloc: _cubit,
              onFailure: (e)=>context.errorBar(message : e.message),
              builder: (s) =>
                   AppButton(text: "Confirm otp",
                      isLoading: s.isLoading,
                      buttonSize: null,
                     onPressed: _onConfirm,
                   ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
