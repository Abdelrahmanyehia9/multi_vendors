import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_colors.dart';
import '../../theme/decorations.dart';
import '../../theme/text_styles.dart';
import '../../utils/testing.dart';
import '../app_cached_network_image.dart';
import '../gap.dart';
import '../rating_stars.dart';
class VendorsCardList extends StatelessWidget {
  final bool shrinkWrap ;
  const VendorsCardList({super.key, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
        shrinkWrap: shrinkWrap,
        separatorBuilder: (_,__)=>Divider(height: 24.h,),
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        itemBuilder: (_, __)=>const VendorCard());
  }
}
class VendorCard extends StatelessWidget {
  const VendorCard({super.key});

  static const Size cardSize = Size(double.infinity, 100);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: cardSize.height.h,
      child: Row(
        children: [
          AppCachedNetworkImage(
            Testing.vendor,
            width: 120,
            height: cardSize.height.h,
            radius: Decorations.borderRadius16,
          ),
          Gap.small(),
          Expanded(
            child: Column(
              spacing: 4.h,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LC Waikiki ", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyles.bodyMedium),
                const RatingStars(rating: 4.2, count: 23),
                Row(
                  spacing: 8.w,
                  children: [
                    _iconText(Icons.delivery_dining, "40 EGP"),
                    _iconText(Icons.timelapse, "20-50 min"),
                  ],
                ),
                Gap.tiny(),
                Row(
                  spacing: 4.w,
                  children: [
                    Text("Deliver by", style: TextStyles.bodySmall.copyWith(color: AppColors.primary)),
                    Text("( Store )", style: TextStyles.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String text) => Row(
    children: [
      Icon(icon, size: 16.sp),
      Gap.tiny(),
      Text(text, style: TextStyles.captionSmall),
    ],
  );
}