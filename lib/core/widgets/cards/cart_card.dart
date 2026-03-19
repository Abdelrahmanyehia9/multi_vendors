import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';

import '../../theme/app_colors.dart';
import '../../theme/decorations.dart';
import '../../theme/text_styles.dart';
import '../../utils/testing.dart';
import '../app_cached_network_image.dart';
import '../gap.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      primary: false,
      padding: EdgeInsets.zero,
      separatorBuilder: (_,i)=>Divider(height: 24.h,).appPaddingHr  ,
      shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_,i)=>const CartCard(),
    );
  }
}


class CartCard extends StatelessWidget {
  final double height;
  const CartCard({super.key, this.height = 100});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return SizedBox(
      height: height.h,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           AppCachedNetworkImage(
            Testing.menShirt,
            width: width * 0.25,
            height: height,
            radius: Decorations.borderRadius16,
          ),
          Gap.small(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Men's Shirts", maxLines: 1,overflow: TextOverflow.ellipsis,  style: TextStyles.labelMedium,),
                 _buildVariation(),
                 Gap.extraSmall(),
                const _AddOrMinusRow(),
              ],
            ),
          ),
          Icon(Icons.close, size: 18.sp,)
        ],
      ),
    );
  }

  Widget _buildVariation()=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Size : Large", style: TextStyles.captionMedium,),
      Text("color : Green", style: TextStyles.captionMedium,),

    ],
  ).paddingHr(4);
}

class _AddOrMinusRow extends StatelessWidget {
  const _AddOrMinusRow();

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12.r,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.add, size: 12.sp, color: AppColors.white
              ,),
          ),
          Text("1", style: TextStyles.labelSmall,).appPaddingHr,
          CircleAvatar(
            radius: 12.r,
            backgroundColor: AppColors.primary,
            child: Icon(Icons.remove, size: 12.r, color: Colors.white,),
          ),
        ],
      ),
    );
  }
}
