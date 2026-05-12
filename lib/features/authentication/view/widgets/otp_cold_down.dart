import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

class OtpCountDownController {
  final ValueNotifier<int> seconds = ValueNotifier(AppConstants.otpColdDown);
  final ValueNotifier<int> attemptsLeft = ValueNotifier(3);

  bool get isFinished => seconds.value == 0;
  bool get hasAttemptsLeft => attemptsLeft.value > 0;

  void dispose() {
    seconds.dispose();
    attemptsLeft.dispose();
  }
}

class OtpColdDown extends StatefulWidget {
  final VoidCallback? onResend;
  final OtpCountDownController? controller;

  const OtpColdDown({super.key, this.onResend, this.controller});

  @override
  State<OtpColdDown> createState() => _OtpColdDownState();
}

class _OtpColdDownState extends State<OtpColdDown> {
  late final OtpCountDownController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? OtpCountDownController();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_controller.seconds.value == 0) {
        timer.cancel();
      } else {
        _controller.seconds.value--;
      }
    });
  }

  void _onResend() {
    if (_controller.attemptsLeft.value <= 1) {
      _controller.attemptsLeft.value = 0;
      return;
    }
    widget.onResend?.call();
    _controller.attemptsLeft.value--;
    _controller.seconds.value = AppConstants.otpColdDown;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        _controller.seconds,
        _controller.attemptsLeft,
      ]),
      builder: (context, _) {
        if (!_controller.hasAttemptsLeft) {
          return Text(
            AppStrings.maxResendReached.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.bodyMedium.copyWith(color: AppColors.error),
          );
        }

        final minutes = (_controller.seconds.value ~/ 60).toString().padLeft(2, '0');
        final seconds = (_controller.seconds.value % 60).toString().padLeft(2, '0');

        return _controller.isFinished
            ? AppClick(
          onTap: _onResend,
          child: Text(
            AppStrings.resendNow.tr(),
            textAlign: TextAlign.center,
            style: TextStyles.bodyMedium.copyWith(color: AppColors.primary),
          ),
        )
            : Text.rich(
          textAlign: TextAlign.center,
          style: TextStyles.bodyMedium,
          TextSpan(
            text: "${AppStrings.resendIn.tr()}\t",
            children: [
              TextSpan(
                text: '$minutes:$seconds',
                style: TextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
              TextSpan(
                text: "\t${AppStrings.secondsPlural.tr()}",
              ),
            ],
          ),
        );
      },
    );
  }
}