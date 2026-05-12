import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_app_bar.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_banner.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_featured_item.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_new_arrivals_section.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_news_section.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_categories.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_product_tags.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_vendors_section.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/shared/view/widgets/slogan_text.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  final GestureTapCallback onSearch;
  const HomeScreen({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HomeAppBar().appPaddingHr,
        Expanded(
          child: ListView(
            children: [
              _homeSearchbar(),
              const HomeBanner().appPaddingHr,

              if (FeatureFlags.multiVendor)...[
                const HomeVendorsSection().appPaddingHr,
              ],
              const HomeNewArrivalsSection().appPaddingAll,
              const HomeShopByCategories().appPaddingHr,
              const HomeFeaturedItem().appPaddingAll,
              if (FeatureFlags.shopByTags) const HomeShopByProductTags().appPaddingHr,
              if (FeatureFlags.hasNews) const HomeNewsSection().appPaddingAll,
            ],
          ),
        )

      ],
    );
  }
  Widget _homeSearchbar()=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SloganText(),
       SizedBox(
         height: 40.h,
         child: AppTextField(
          onTap: onSearch,
          padding: EdgeInsets.zero,
          hintText: '${AppStrings.search.tr()} ....',
          hintStyle: TextStyles.captionMedium,
          borderType: AppBorderType.filled,
          readOnly: true,
          prefix: const Icon(MvIcons.search),
               ),
       ),
    ],
  ).appPaddingHr;
}
