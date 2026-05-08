import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_favorite_button.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/shared/view/widgets/app_chip.dart';
import 'package:multi_vendor/shared/view/widgets/photo_overlay.dart';

class VendorAppBar extends StatelessWidget {
  final ValueNotifier<bool> collapsed ;
  final double expandedHeight ;
  final VendorDetailsModel vendor ;
  const VendorAppBar({super.key,required this.vendor , required this.expandedHeight ,required this.collapsed});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: collapsed,
      builder: (_, collapsed, __) => BaseSliverAppBar(
        expandedHeight: expandedHeight.h,
        iconColor: collapsed?null:Colors.white,
        iconBackgroundColor: collapsed?null:Colors.transparent,
        backgroundColor: context.scaffoldBackground,
        elevation: collapsed ? 2 : 0,
        title: _buildAppBarTitle(collapsed),
        actions: [
          if(vendor.id!=null)
          AppFavoriteButton(item: vendor, size: 24, padding: 8,),
        ],
        flexibleSpace: _VendorProfileCover(collapsed: collapsed, vendor: vendor,),
      ),
    );
  }
  Widget _buildAppBarTitle(bool collapsed)=>AnimatedOpacity(
    opacity: collapsed ? 1 : 0,
    duration: const Duration(milliseconds: 400),
    child: Padding(
      padding: EdgeInsetsDirectional.only(top: 8.h),
      child: Row(
        spacing: 4.w,
        children: [
          Text(vendor.name.localized, style: TextStyles.labelMedium),
          if(vendor.isVerified)
          const Icon(MvIcons.verified , color: AppColors.success,),
        ],
      ),
    ),
  ) ;

}

class _VendorProfileCover extends StatelessWidget {
  final bool collapsed ;
  final VendorDetailsModel vendor ;
  const _VendorProfileCover({this.collapsed = false,required this.vendor});

  @override
  Widget build(BuildContext context) {
    return  FlexibleSpaceBar(
      stretchModes: const [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ],
      background: PhotoOverlay(
        img: vendor.image,
        title: AnimatedOpacity(
          opacity: collapsed ? 0 : 1,
          duration: const Duration(milliseconds: 200),
          child: Row(
            children: [
              Text(
                vendor.name.localized,
                style: TextStyles.labelLarge.copyWith(
                  color: Colors.white,
                  shadows: const [
                    Shadow(blurRadius: 8, color: Colors.black54)
                  ],
                ),
              ),
              Gap.small(),
              if(vendor.isVerified)
              Icon(MvIcons.verified,size: 24.sp,color: AppColors.success,),
              if(FeatureFlags.enableMultiShipping)...[
                const Spacer(),
                if(vendor.deliveryOption?.deliveryByStore??false)
                 AppChip(
                   selected: true,
                   selectedColor: AppColors.grey100,
                   text: AppStrings.deliverByStore.tr(),
                   labelColor: AppColors.black,
                  selectedBorderColor: Colors.transparent,
                  unSelectedBorderColor: Colors.transparent,
                )
              ]

            ],
          ),
        ),
      ),
    ) ;
  }
}