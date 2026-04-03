import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import '../models/action_model.dart';
import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import 'app_button.dart';

enum States {
  error,
  empty;

  String get image {
    switch (this) {
      case error:
        return AppAssets.errorIllustration;
      case empty:
        return AppAssets.emptyIllustration;
    }
  }

  String get message {
    switch (this) {
      case error:
        return "there was an error while loading data";
      case empty:
        return "no data available";
    }
  }
}

class AppStates extends StatelessWidget {
  final States state;
  final double size;
  final IconData? customIcon;
  final String? customSvg;
  final String? message;
  final ActionModel? actionModel;

  const AppStates({
    super.key,
    this.actionModel,
    this.customIcon,
    this.customSvg,
    this.size = 20,
    this.message,
    required this.state,
  });

  factory AppStates.error(
    AppException e, {
    double size = 20,
    IconData? customIcon,
    String? customSvg,
    ActionModel? actionModel,
  }) => AppStates(
    state: States.error,
    message: e.message,
    customIcon: customIcon,
    customSvg: customSvg,
    size: size,
    actionModel: actionModel,
  );

  factory AppStates.empty({
    double size = 20,
    IconData? customIcon,
    String? customSvg,
    ActionModel? actionModel,
    String? message,
  }) => AppStates(
    state: States.empty,
    customIcon: customIcon,
    customSvg: customSvg,
    size: size,
    message: message,
    actionModel: actionModel,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildImage(),
          Text(
            message ?? state.message,
            style: TextStyles.headline3.copyWith(
              fontWeight: FontWeightHelper.regular,
              fontSize: size * .7.sp,
              color: AppColors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          if (actionModel != null)
            AppButton(
              text: actionModel!.text,
              onPressed: () => actionModel?.action?.call(context),
              fixedSize: Size(size * 7, size * 1.4),
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontSize: size * .586.sp,
              ),
            ).paddingVr(size * .6),
        ],
      ).paddingAll(size),
    );
  }

  Widget _buildImage() {
    if (customIcon != null) {
      return Opacity(
        opacity: 0.8,
        child: Icon(
          customIcon,
          color: AppColors.primary,
          size: size * 4.7,
        ).appPaddingVr,
      );
    }
    return SvgPicture.asset(
      customSvg ?? state.image,
      height: (size * 10).h,
      fit: BoxFit.cover,
    );
  }
}
