import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';

import '../../theme/decorations.dart';
import '../../theme/text_styles.dart';
import '../../utils/testing.dart';
import '../app_cached_network_image.dart';
import '../gap.dart';
import '../section_header.dart';

class CheckoutProductList extends StatelessWidget {
  final bool showHeader ;
  const CheckoutProductList({super.key, this.showHeader =false});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        if(showHeader) const SectionHeader(title: "Ordered Products"),
        ListView.separated(
          itemCount: 4,
          primary: false,
          padding: EdgeInsets.zero,
          separatorBuilder: (_,i)=>Gap.medium()  ,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_,i)=>const CheckoutProductCard(),
        ),
      ],
    );
  }
}


class CheckoutProductCard extends StatelessWidget {
  final double height ; 
  const CheckoutProductCard({super.key, this.height = 70});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return SizedBox(
      height: height.h,
      child: Row(
        children: [
          AppCachedNetworkImage(
            Testing.menShirt,
            width: width * 0.2,
            height: height,
            radius: Decorations.borderRadius8,
          ),
          Gap.small(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Men's Shirts", maxLines: 1,overflow: TextOverflow.ellipsis,  style: TextStyles.labelMedium,),
                _buildVariation(),
              ],
            ),
          ),
          Text("x5", style: TextStyles.labelMedium.copyWith(color: AppColors.primary),).paddingHr(8)
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
