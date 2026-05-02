part of 'product_filters_sheet.dart';

class _CategoryCheckbox extends StatelessWidget {
  final bool checked;
  final bool partial;

  const _CategoryCheckbox({required this.checked, this.partial = false});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.primary;
    final active = checked || partial;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 18.w,
      height: 18.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(color: active ? color : context.colors.surfaceContainer, width: 1.5.w),
        color: checked ? color : partial ? color.withAppOpacity(0.15) : Colors.transparent,
      ),
      child: checked
          ? Icon(MvIcons.checked, color: Colors.white, size: 12.sp)
          : partial
          ? Icon(MvIcons.remove, color: color, size: 12.sp)
          : null,
    );
  }
}