import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_app_bar.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_banner.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_new_arrival.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_news_section.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_categories.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_tags.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_vendors_section.dart';

import '../../../../core/utils/app_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const HomeAppBar().appPaddingHr,
          Gap.small(),
          _buildSearchTextField(),
          const HomeBanner(),
          Gap.small(),
          if(AppConstants.multiVendor)
          const HomeVendorsSection().appPaddingHr,
          const HomeShopByCategories().appPaddingAll,
          const HomeNewArrival().appPaddingHr,
          if(AppConstants.shopByTags)
          const ShopByTags().appPaddingAll,
          if(AppConstants.hasNews)
          const HomeNewsSection().appPaddingHr,

        ],
      ),
    );
  }
  Widget _buildSearchTextField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
            TextSpan(
                text: "Discover Your Best ",
                style: TextStyles.bodyLarge,
                children: [
                  TextSpan(text: "Fashion !", style: TextStyles.bodyLarge.copyWith(
                      color: AppColors.primary
                  ))
                ]
            )
        ),
        Gap.extraSmall(),
        AppTextField(
          hintText: 'Search',
          borderType: TextFieldBorderType.filled,
          padding: EdgeInsets.zero,
          hintStyle: TextStyles.captionMedium,
          prefix: const Icon(Icons.search),
        )
      ],
    ).appPaddingHr ;
  }
}
