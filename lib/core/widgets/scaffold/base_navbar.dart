import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

class BaseNavbar extends StatefulWidget {
  final List<BoxShadow>? shadow;
  final bool showLabel;
  final List<NavbarItem> items;
  final int initialIndex;

  final void Function(int)? onSelect;

  const BaseNavbar({
    super.key,
    this.initialIndex = 0,
    required this.items,
    this.onSelect,
    this.shadow,
    this.showLabel = false,
  });

  @override
  State<BaseNavbar> createState() => _BaseNavbarState();
}

class _BaseNavbarState extends State<BaseNavbar> {
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseNavbar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialIndex != widget.initialIndex) {
      _selectedIndex = widget.initialIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      right: false,
      left: false,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: context.scaffoldBackground,
          boxShadow: widget.shadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.items.length,
            (index) => AppClick(
              onTap: () {
                widget.onSelect?.call(index);
                setState(() => _selectedIndex = index);
              },
              child: _buildItem(
                item: widget.items[index],
                isSelected: _selectedIndex == index,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItem({required NavbarItem item, bool isSelected = false}) {
    final label = item.label;
    final icon = item.icon;
    final tooltip = item.toolTip ?? label;
    return Tooltip(
      message: tooltip,
      child: AnimatedContainer(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
          color: isSelected  ?  AppColors.primary : Colors.transparent
        ),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child:
            item.child ??
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: isSelected ? 26.sp : 23.sp,
                  color: isSelected
                      ? AppColors.white
                      : context.colors.surfaceContainer,
                ),
                if (isSelected && widget.showLabel) ...[
                  Text(
                    label,
                    style: TextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      letterSpacing: 0,
                      height: 0,
                    ),
                  ),
                ],
              ],
            ),
      ),
    );
  }
}

class NavbarItem {
  final IconData icon;
  final String label;
  final String? toolTip;
  final Widget? child;

  final Widget Function() pageBuilder;

  const NavbarItem({
    required this.icon,
    required this.label,
    required this.pageBuilder,
    this.toolTip,
    this.child,
  });
}
