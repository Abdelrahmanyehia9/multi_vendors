import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({super.key, String? title, super.actions})
      : super(
    title: title == null
        ? null
        : Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Text(
        title,
        style: TextStyles.bodyMedium,
      ),
    ),
    leading: _buildLeading(),
    leadingWidth: 60.sp,
    toolbarHeight: 60.sp,
    actionsPadding: EdgeInsetsDirectional.only(top: 12.h, end: 16.w),
    scrolledUnderElevation: 0,
    bottom: PreferredSize(
      preferredSize:  Size.fromHeight(24.h),
      child: const SizedBox.shrink(),
    ),
  );

  static Widget _buildLeading() {
    return Builder(
      builder: (context) {
        final canPop = Navigator.of(context).canPop();
        return Padding(
          padding: EdgeInsetsDirectional.only(
            start: 16.w,
            top: 16.h,
          ),
          child: AppIconButton(
            icon: Icons.arrow_back,
            size: 24,
            onTap: () {
              if (canPop) {
                context.pop();
              } else {
                context.pushNamedAndRemoveUntil(Routes.mainLayout, predicate: (_)=>false);
              }
            },
          ),
        );
      },
    );
  }}