import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';

import 'package:multi_vendor/core/service/image_picker_service.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

class ChooseImageSource extends StatefulWidget {
  const ChooseImageSource({super.key});
  @override
  State<ChooseImageSource> createState() => _ChooseImageSourceState();
}
class _ChooseImageSourceState extends State<ChooseImageSource> {
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8.h,
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundColor: AppColors.primary,
          radius: 36.r,
          child: Icon(
            CupertinoIcons.photo_fill_on_rectangle_fill,
            color: Colors.white,
            size: 40.sp,
          ),
        ),
        Text(
          "Choose Source",
          textAlign: TextAlign.center,
          style: TextStyles.bodyLarge,
        ),
        Text(
          "Choose image source camera or gallery",
          textAlign: TextAlign.center,
          style: TextStyles.bodyMedium.copyWith(
            color: context.colors.surfaceContainer,
            fontWeight: FontWeightHelper.regular,
          ),
        ),
        Gap.small(),
        ...ImagePickerSource.values.map(
              (item) => AppClick(
            onTap: () => context.pop(item),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(
                  color:  context.colors.surfaceContainerLow,
                ),
                borderRadius:
                BorderRadius.circular(Decorations.borderRadius8.r),
              ),
              child: Row(
                spacing: 12.sp,
                children: [
                  Icon(item.icon),
                  Text(item.text, style: TextStyles.bodyMedium),
                ],
              ).appPaddingHr,
            ),
          ),
        ),
      ],
    ).appPaddingAll;
  }
}