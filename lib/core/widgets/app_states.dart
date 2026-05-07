import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/shared/data/models/action_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

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
        return AppStrings.thereWasAnErrorWhileLoadingData.tr();
      case empty:
      return AppStrings.noDataAvailable.tr();
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
          _buildImage(context),
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
              buttonSize: null,
              borderRadius: Decorations.borderRadius4,
              fixedSize: Size(size * 7, size * 1.5),
              padding: EdgeInsets.zero,
              style: TextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontSize: size * .586.sp,
              ),
            ).paddingVr(size * .6),
        ],
      ).paddingAll(size),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (customIcon != null) {
      return Opacity(
        opacity: 0.8,
        child: Icon(
          customIcon,
          color: context.colors.surfaceContainerLow,
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
