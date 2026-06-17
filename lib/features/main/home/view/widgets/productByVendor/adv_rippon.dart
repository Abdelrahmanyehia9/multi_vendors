part of '../home_product_by_vendor.dart';

class _AdvRibbon extends StatelessWidget {
  const _AdvRibbon();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topEnd,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 110.w,
          minWidth: 110.w,
          minHeight: 30.h,
          maxHeight: 40.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.warning,
          boxShadow: Decorations.shadow,
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Center(
          heightFactor: 1,
          child: Text(
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            AppStrings.advertisement.tr(),
            style: TextStyles.bodySmall.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
