import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/user_avatar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         const UserAvatar(
           size: 48,
         ),
        Gap.small(),
        _nameWithLocation(),
        Gap.small(),
        /// Notifications
        AppButton.icon(
          fixedSize: const Size(40, 40),
          borderRadius: Decorations.borderRadius16,
          color: context.colors.surfaceContainerLow,
          icon: Icon(
            Icons.notifications,
            size: 24.sp,
            color: context.colors.surfaceContainerHigh,
          ),
        ),
        Gap.small(),
        /// Cart
        Badge(
          label: const Text('1'),
          child: AppButton.icon(
            fixedSize: const Size(40, 40),
            borderRadius: Decorations.borderRadius16,
            color: context.colors.surfaceContainerLow,
            icon: Icon(
              Icons.shopping_bag,
              size: 24.sp,
              color: context.colors.surfaceContainerHigh,
            ),
          ),
        ),
      ],
    );
  }

  Widget _nameWithLocation(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "ahmed khaled",
            maxLines: 1,
            style: TextStyles.labelSmall,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(Icons.location_pin, size: 15.sp),
               Expanded(
                child: Text(
                  "6 october city , Egypt" ,
                  style: TextStyles.captionMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ) ;
  }
}