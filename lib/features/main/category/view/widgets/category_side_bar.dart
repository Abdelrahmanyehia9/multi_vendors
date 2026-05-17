import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_logo.dart';
import 'package:multi_vendor/features/main/category/data/model/category_model.dart';

class CategorySideBar extends StatelessWidget {
  final ValueNotifier<CategoryModel?> selectedMainCategory;
  final List<CategoryModel> categories;

  const CategorySideBar({
    super.key,
    required this.selectedMainCategory,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final Color surfaceLowest = context.colors.surfaceContainerLowest;
    final Color selectedColor =  AppColors.primary;
    return ValueListenableBuilder(
      valueListenable: selectedMainCategory,
      builder: (context, value, child) {
        return Container(
          width: 70.w,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: context.scaffoldBackground,
            border: Border(
              right: context.isRTL
                  ? BorderSide.none
                  : BorderSide(color: surfaceLowest, width: 0.5),
              left: context.isRTL
                  ? BorderSide(color: surfaceLowest , width: 0.5)
                  : BorderSide.none,
            ),
            borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: categories.length,
            itemBuilder: (_, i) {
              final isActive = value == categories[i];
              return AppClick(
                onTap: () => selectedMainCategory.value = categories[i],
                child: AnimatedContainer(
                  alignment: AlignmentDirectional.center,
                  curve: Curves.bounceInOut,
                  decoration: BoxDecoration(
                    border: Border(
                      right: !context.isRTL && isActive
                          ? BorderSide(color: selectedColor, width: 2)
                          : BorderSide.none,

                      left: context.isRTL && isActive
                          ? BorderSide(color: selectedColor, width: 2)
                          : BorderSide.none,
                    ),
                    color: isActive
                        ? selectedColor.veryLight
                        : Colors.transparent,
                  ),
                  duration: const Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                  child: Column(
                    spacing: 8.h,
                    children: [
                      Container(
                        width: 46.w,
                        height: 46.w,
                        decoration: BoxDecoration(
                          color: isActive
                              ? selectedColor.lighten(0.2)
                              : surfaceLowest.withAppOpacity(0.6),
                          borderRadius: BorderRadius.circular(
                            Decorations.borderRadius8.r,
                          ),
                        ),
                        child: categories[i].icon == null
                            ? const AppLogo(size: 24)
                            : Center(
                                child: SvgPicture.network(
                                  categories[i].icon!,
                                  width: 24.w,
                                  height: 24.w,
                                ),
                              ),
                      ),
                      Text(
                        categories[i].name.localized,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.bodySmall.copyWith(
                          color: isActive?   selectedColor : null,
                          fontWeight: FontWeightHelper.medium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ).paddingHr(4);
  }
}
