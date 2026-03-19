import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_product_tags.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_vendors_section.dart';
import '../../../../core/utils/feature_flags.dart';

class HomeScreen extends StatelessWidget {
  final GestureTapCallback onSearch;
  const HomeScreen({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppBar().appPaddingHr,
          Gap.small(),
          StoreSearchBar(onTap: onSearch).appPaddingHr,
          const HomeBanner(),
          Gap.small(),
          if (FeatureFlags.multiVendor) const HomeVendorsSection().appPaddingHr,
          const HomeShopByCategories().appPaddingAll,
          const HomeNewArrival().appPaddingHr,
          if (FeatureFlags.shopByTags) const ShopByProductTags().appPaddingAll,
          if (FeatureFlags.hasNews) const HomeNewsSection().appPaddingHr,
        ],
      ),
    );
  }
}

class StoreSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;

  const StoreSearchBar({
    super.key,
    this.focusNode,
    this.onTap,
     this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (focusNode == null) return _buildColumn();

    return ListenableBuilder(
      listenable: focusNode!,
      builder: (context, _) => _buildColumn(),
    );
  }

  Widget _buildColumn() {
    bool hasFocus= focusNode == null || !focusNode!.hasFocus ;
    return Column(
    spacing: 8.sp,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (hasFocus)
        Text.rich(
          TextSpan(
            text: "Discover Your Best ",
            style: TextStyles.labelLarge,
            children: [
              TextSpan(
                text: "Fashion !",
                style: TextStyles.labelLarge.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
      AppTextField(
        focusNode: focusNode,
        hintText: 'Search',
        padding: hasFocus ?  EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 16.w),
        borderType: AppBorderType.filled,
        controller: controller,
        onTap: onTap,
        hintStyle: TextStyles.captionMedium,
        prefix: !hasFocus? null :  const Icon(Icons.search),
      ),
    ],
  );
  }
}