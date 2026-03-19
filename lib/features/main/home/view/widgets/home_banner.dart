import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/utils/testing.dart';
import '../../../../../core/widgets/gap.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const _Slide();
  }
}
class _Slide extends StatelessWidget {
  const _Slide();

  @override
  Widget build(BuildContext context) {
    final height = 164.h;
    final width = context.width;
    final img = Testing.girlPhoto;
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            width: width - 20.w,
            height: height-16.h,
            constraints: BoxConstraints(minHeight: height - 20.h),
            decoration: BoxDecoration(
              color: AppColors.grey700,
              borderRadius: BorderRadius.circular(Decorations.borderRadius16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("70% OFF",
                          style: TextStyles.bodyMedium
                              .copyWith(color: Colors.white)),
                      Text(
                        "Get this promo at the beginning of the month",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.captionMedium
                            .copyWith(color: Colors.white),
                      ),
                      Gap.small(),
                      AppButton(
                        text: "Shop Now",
                        style: TextStyles.bodySmall,
                        onPressed: ()=> context.pushNamed(Routes.products),
                        fixedSize: const Size(100, 30),
                        padding: EdgeInsets.zero,
                        buttonSize: null,
                      ),
                    ],
                  ).appPaddingAll,
                ),
                Gap(width * .3),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: AppCachedNetworkImage(img, width: width * .45, height: height),
          ),
        ],
      ),
    );
  }
}