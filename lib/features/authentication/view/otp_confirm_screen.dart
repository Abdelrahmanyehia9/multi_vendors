import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/authentication/view/mixin/otp_confirm_screen_mixin.dart';
import 'package:multi_vendor/features/authentication/view/widgets/auth_fields.dart';
import 'package:multi_vendor/features/authentication/view/widgets/otp_cold_down.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

class OtpConfirmScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpConfirmScreen({super.key, required this.phoneNumber});

  @override
  State<OtpConfirmScreen> createState() => _OtpConfirmScreenState();
}

class _OtpConfirmScreenState extends State<OtpConfirmScreen>
    with OtpConfirmScreenMixin {
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
              AppStrings.confirmYourNumber.tr(),
              textAlign: TextAlign.center,
              style: TextStyles.headline3,
            ),
            Text(
              "${AppStrings.pleaseEnterThe6DigitCodeSentToYourNumber.tr()} ${widget.phoneNumber} ${AppStrings.toCompleteTheVerificationProcess.tr()}",
              textAlign: TextAlign.center,
              style: TextStyles.bodyMedium.copyWith(
                color: context.colors.surfaceContainer,
              ),
            ),
            Gap.small(),
            PinCode(controller: controller, onComplete: (_) => onConfirm()),
            OtpColdDown(
              controller: otpColdDownController,
              onResend: onResendOtp,
            ),
            Gap.small(),
            BaseBlocConsumer(
              bloc: cubit,
              onFailure: onConfirmFailure,
              builder: (s) => AppButton(
                text: AppStrings.confirmOtp.tr(),
                isLoading: s.isLoading,
                buttonSize: null,
                onPressed: onConfirm,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
