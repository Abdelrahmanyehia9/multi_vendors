import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_app_bar.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_banner.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_featured_item.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_news_section.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_categories.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_product_tags.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_vendors_section.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/shared/view/widgets/app_search_bar.dart';
import 'package:multi_vendor/shared/view/widgets/slogan_text.dart';

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
        Gap.tiny(),
        Expanded(
          child: ListView(
            children: [
              AppSearchbar(
                  title: const SloganText(),
                  onTap: onSearch).appPaddingHr,
              const HomeBanner(),
              Gap.small(),
              if (FeatureFlags.multiVendor)...[
                const HomeVendorsSection().appPaddingHr,
              ],
              const HomeShopByCategories().appPaddingAll,
              const HomeFeaturedItem().appPaddingHr,
              if (FeatureFlags.shopByTags) const HomeShopByProductTags().appPaddingAll,
              if (FeatureFlags.hasNews) const HomeNewsSection().appPaddingHr,
            ],
          ),
        )

      ],
    );
  }
}

