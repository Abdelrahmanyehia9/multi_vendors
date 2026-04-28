import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

class BaseTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String>? tabs;
  final bool scrollable;
  final double? borderRadius;
  final void Function(int)? onTap;

  final List<Widget>? customTabs;
  final TabAlignment alignment;
  final TextStyle? style;
  final Color color;

  const BaseTabBar({
    super.key,
    this.onTap,
    this.customTabs,
    this.borderRadius,
    this.style,
    this.color = AppColors.primary,
    this.alignment = TabAlignment.start,
    required this.controller,
    this.scrollable = true,
    this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    assert(customTabs != null || tabs != null);
    return TabBar(
      onTap: onTap,
      controller: controller,
      isScrollable: scrollable,
      indicatorAnimation: TabIndicatorAnimation.linear,
      dividerColor: Colors.transparent,
      tabAlignment: alignment,
      indicatorSize: TabBarIndicatorSize.tab,
      padding: EdgeInsets.zero,
      splashBorderRadius: BorderRadius.circular(
        borderRadius?.r ?? Decorations.borderRadius8.r,
      ),
      indicator: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          borderRadius?.r ?? Decorations.borderRadius8.r,
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      labelColor: Colors.white,
      unselectedLabelColor: context.colors.surfaceContainerHigh,
      labelPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      tabs:
      customTabs ??
          tabs!
              .map(
                (e) => Text(
                              e,
                              style:
                              style ?? TextStyles.labelSmall.copyWith(fontSize: 14.sp),
                            ),
          )
              .toList(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(40.h);
}
