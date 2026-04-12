import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_details_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/feature_flags.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/photo_overlay.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';

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
          Text(vendor.name, style: TextStyles.labelMedium),
          if(vendor.isVerified)
          const Icon(Icons.verified , color: AppColors.success,)
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
                vendor.name,
                style: TextStyles.headline3.copyWith(
                  color: Colors.white,
                  shadows: const [
                    Shadow(blurRadius: 8, color: Colors.black54)
                  ],
                ),
              ),
              Gap.small(),
              if(vendor.isVerified)
              Icon(Icons.verified,size: 24.sp,color: AppColors.success,),
              if(FeatureFlags.enableMultiShipping)...[
                const Spacer(),
                if(vendor.deliveryOption?.deliveryByStore??false)
                const AppChip(text: "Deliver By Store", padding: EdgeInsets.zero,
                  elevation: 12,
                  labelColor: AppColors.black,
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