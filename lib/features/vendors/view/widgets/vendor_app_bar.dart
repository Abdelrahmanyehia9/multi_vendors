import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/testing.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import '../../../../core/widgets/app_chip.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';

class VendorAppBar extends StatelessWidget {
  final ValueNotifier<bool> collapsed ;
  final double expandedHeight ;
  const VendorAppBar({super.key,required this.expandedHeight ,required this.collapsed});

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
        flexibleSpace: _VendorProfileCover(collapsed: collapsed),
      ),
    );
  }
  Widget _buildAppBarTitle(bool collapsed)=>AnimatedOpacity(
    opacity: collapsed ? 1 : 0,
    duration: const Duration(milliseconds: 400),
    child: Padding(
      padding: EdgeInsetsDirectional.only(top: 16.h),
      child: Row(
        children: [
          Text("LC Waikiki", style: TextStyles.labelMedium),
          Gap.extraSmall(),
          const Icon(Icons.verified , color: AppColors.success,)
        ],
      ),
    ),
  ) ;

}

class _VendorProfileCover extends StatelessWidget {
  final bool collapsed ;
  const _VendorProfileCover({this.collapsed = false});

  @override
  Widget build(BuildContext context) {
    return  FlexibleSpaceBar(
      stretchModes: const [
        StretchMode.zoomBackground,
        StretchMode.blurBackground,
      ],
      background: Stack(
        fit: StackFit.expand,
        children: [
          const AppCachedNetworkImage(Testing.vendor),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black26, Colors.black54],
                stops: [0.5, 1],
              ),
            ),
          ),
          Positioned(
            left: 16.w,
            right: 16.w,
            bottom: 16.h,
            child: AnimatedOpacity(
              opacity: collapsed ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: Row(
                children: [
                  Text(
                    "LC Waikiki",
                    style: TextStyles.headline3.copyWith(
                      color: Colors.white,
                      shadows: const [
                        Shadow(blurRadius: 8, color: Colors.black54)
                      ],
                    ),
                  ),
                  Gap.small(),
                  Icon(Icons.verified,size: 24.sp,color: AppColors.success,),
                  if(AppConstants.enableMultiShipping)...[
                    const Spacer(),
                    const AppChip(text: "Deliver By Store", padding: EdgeInsets.zero,
                      elevation: 12,
                      labelColor: AppColors.black,
                      borderColor: Colors.transparent,
                    )
                  ]

                ],
              ),
            ),
          ),
        ],
      ),
    ) ;
  }
}