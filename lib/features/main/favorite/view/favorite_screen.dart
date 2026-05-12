import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_tab_bar.dart';
import 'package:multi_vendor/features/main/favorite/logic/favorite_cubit.dart';
import 'package:multi_vendor/features/vendors/view/widgets/vendor_card.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/shared/view/layouts/product_grid.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_model.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
    with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }
  Widget _emptyOrWidget(bool isEmpty, Widget child) =>
      isEmpty ? AppStates.empty() : child.appPaddingHr;

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<FavoriteCubit, FavoriteModel>(
      successBuilder: (favorites) {
        final products = _emptyOrWidget(
          favorites.favoriteProducts.isEmpty,
          ProductGrid(products: favorites.favoriteProducts),
        );

        final vendors = _emptyOrWidget(
          favorites.favoriteVendors.isEmpty,
          VendorCardGrid(vendors: favorites.favoriteVendors),
        );

        return Column(
          children: [
            SizedBox(
              height: 70.h,
              child:  BaseAppBar(
                title: AppStrings.favorites.tr(),
                showLeading: false,
              ),
            ),
            if (!FeatureFlags.multiVendor)
              Expanded(child: products)
            else ...[
              BaseTabBar(
                alignment: TabAlignment.center,
                controller: controller,
                tabs:  [AppStrings.products.tr(), AppStrings.vendors.tr()],
              ),
              Gap.large(),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [products, vendors],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}