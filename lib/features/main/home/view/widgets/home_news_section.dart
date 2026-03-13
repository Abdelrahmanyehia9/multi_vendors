import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_section_header.dart';

import '../../../../../core/utils/testing.dart';
import '../../../../../core/widgets/gap.dart';

class HomeNewsSection extends StatelessWidget {
  const HomeNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HomeSectionHeader(title: "Featured News"),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (_, __) => _buildNewsItem(),
        ),
      ],
    );
  }

  Widget _buildNewsItem() {
    return SizedBox(
      height: 100.h,
      child: Row(
        children: [
          AppCachedNetworkImage(
            Testing.girlModel,
            height: 100.h,
            radius: Decorations.borderRadius8,
            width: 100.w,
          ),
          Gap.small(),
          Expanded(
            child: Column(
              spacing: 4.h,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Fashion Celebrates Beauty in All Shapes and Sizes",
                  style: TextStyles.bodySmall,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),

                Text(
                  "The fashion industry is increasingly embracing diversity by featuring models that represent a variety of body shapes, skin colors and backgrounds.",
                  style: TextStyles.captionSmall,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ).paddingVr(4);
  }
}
