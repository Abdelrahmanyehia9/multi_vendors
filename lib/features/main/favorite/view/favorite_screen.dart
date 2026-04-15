import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/core/widgets/login_required.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_tab_bar.dart';
import 'package:multi_vendor/features/main/favorite/logic/favorite_cubit.dart';
import 'package:multi_vendor/features/vendors/view/widgets/vendor_card.dart';
import '../../../../core/utils/feature_flags.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';
import '../data/model/favorite_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return LoginRequired(
      child: BaseBlocConsumer<FavoriteCubit, FavoriteModel>(
        successBuilder:(favorites)=> Column(
          children: [
            SizedBox(
              height: 70.h,
              child: BaseAppBar(title: "Favorite", showLeading: false,),
            ),
            if (FeatureFlags.multiVendor) ...[
              BaseTabBar(
                alignment: TabAlignment.center,
                controller: controller,
                tabs: const ['Products', "Vendors"],
              ),
              Gap.large(),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                   favorites.favoriteProducts.isEmpty?AppStates.empty():  ProductGrid(products: favorites.favoriteProducts,).appPaddingHr,
                   favorites.favoriteVendors.isEmpty?AppStates.empty():  VendorCardGrid(vendors: favorites.favoriteVendors,).appPaddingHr,
                  ],
                ),
              ),
            ] else
              Expanded(child: const ProductGrid(products: [],).appPaddingHr),
          ],
        ),
      ),
    );
  }
}

