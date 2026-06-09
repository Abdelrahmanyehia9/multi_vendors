import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_text_field.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/features/main/category/logic/sub_categories_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_banner_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_featured_item_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_news_arrivals_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_news_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_on_going_order_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_tags_filter_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_vendors_cubit.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_app_bar.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_banner.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_featured_item.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_new_arrivals_section.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_news_section.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_on_going_order.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_categories.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_shop_by_product_tags.dart';
import 'package:multi_vendor/features/main/home/view/widgets/home_vendors_section.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/features/main/main_layout_cubit.dart';
import 'package:multi_vendor/shared/view/widgets/slogan_text.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _onRefresh(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeAppBar().appPaddingHr,
          Gap.extraSmall(),
          Expanded(
            child: ListView(
              children: [
                Gap.small(),
                _homeSearchbar(
                  onSearch: () => context.read<MainLayoutCubit>().changePage(2),
                ),
                const HomeOnGoingOrder().paddingVr(8),
                const HomeBanner(),
                if (FeatureFlags.multiVendor) ...[
                  const HomeVendorsSection().appPaddingHr,
                ],
                const HomeNewArrivalsSection().appPaddingAll,
                const HomeShopByCategories().appPaddingHr,
                const HomeFeaturedItem().appPaddingAll,
                if (FeatureFlags.shopByTags)
                  const HomeShopByProductTags().appPaddingHr,
                if (FeatureFlags.hasNews) const HomeNewsSection().appPaddingAll,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeSearchbar({GestureTapCallback? onSearch}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SloganText(),
      SizedBox(
        height: 36.h,
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
  Future<void> _onRefresh(BuildContext context) async {
    context.read<HomeBannerCubit>().getBanners();
    context.read<HomeVendorsCubit>().getAllVendors();
    context.read<HomeNewsArrivalsCubit>().getNewsArrivals();
    context.read<SubCategoriesCubit>().getSubCategories();
    context.read<HomeFeaturedItemCubit>().getFeaturedItem();
    context.read<HomeTagsFilterCubit>().getTags();
    context.read<HomeNewsCubit>().getNews();
    context.read<HomeOnGoingOrderCubit>().getOnGoing();
  }
}
