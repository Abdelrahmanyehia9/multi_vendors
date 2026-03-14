import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

import '../../theme/app_colors.dart';
import '../../theme/text_styles.dart';
import '../gap.dart';

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
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
    );
  }
  Widget _buildItem({required NavbarItem item, bool isSelected = false}) {
    final label = item.label;
    final icon = item.icon;
    final tooltip = item.toolTip ?? label;
    return Tooltip(
      message: tooltip,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 16.w : 12.w,
          vertical: 8.h,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22.r,
              color: isSelected
                  ? AppColors.white
                  : context.colors.surfaceContainer,
            ),
            if (isSelected && widget.showLabel) ...[
              const Gap(6),
              Text(
                label,
                style: TextStyles.bodySmall.copyWith(color: AppColors.primary),
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
  final Widget page ;

  NavbarItem({required this.icon, required this.label, required this.page, this.toolTip});
}
