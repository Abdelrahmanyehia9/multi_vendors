import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_navbar.dart';
import 'package:multi_vendor/features/main/favorite/view/favorite_screen.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/features/main/home/logic/home_banner_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_featured_item_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_news_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_product_by_category_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_tags_filter_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_vendors_cubit.dart';
import 'package:multi_vendor/features/main/home/view/home_screen.dart';
import 'package:multi_vendor/features/main/main_layout_cubit.dart';
import 'package:multi_vendor/features/main/profile/view/profile_screen.dart';
import 'package:multi_vendor/features/main/search/data/repository/search_repository.dart';
import 'package:multi_vendor/features/main/search/logic/search_product_history_cubit.dart';
import 'package:multi_vendor/features/main/search/logic/search_products_cubit.dart';
import 'package:multi_vendor/features/main/search/view/search_screen.dart';
import 'package:multi_vendor/features/main/main_layout.dart';
import 'package:multi_vendor/features/shop/history/data/repository/order_history_repository.dart';
import 'package:multi_vendor/features/shop/history/logic/order_history_cubit.dart';
import 'package:multi_vendor/features/shop/history/view/order_history_screen.dart';

import 'package:multi_vendor/shared/logic/search_cubit.dart';
import 'package:multi_vendor/shared/logic/shop_categories_cubit.dart';

mixin MainLayoutMixin on State<MainLayout> {
  MainLayoutCubit get cubit => context.read<MainLayoutCubit>()  ;
  late final List<NavbarItem> items;
  late final List<Widget?> _loadedPages;

  @override
  void initState() {
    super.initState();
    items = _buildItems();
    _loadedPages = List.generate(items.length, (_) => null);
    _loadedPages[widget.initialIndex] = items[widget.initialIndex]
        .pageBuilder();
  }

  List<NavbarItem> _buildItems() {
    return [
      NavbarItem(
        icon: Icons.home,
        label: "Home",
        pageBuilder: () => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  HomeCategoriesCubit(getIt<HomeRepository>())..getCategories(),
            ),
            BlocProvider(
              create: (_) =>
                  HomeVendorsCubit(getIt<HomeRepository>())..getAllVendors(),
            ),
            BlocProvider(
              create: (_) =>
                  HomeProductByCategoryCubit(getIt<HomeRepository>()),
            ),
            BlocProvider(
              create: (_) =>
                  HomeFeaturedItemCubit(getIt<HomeRepository>())
                    ..getFeaturedItem(),
            ),
            BlocProvider(
              create: (_) =>
                  HomeTagsFilterCubit(getIt<HomeRepository>())..getTags(),
            ),
            BlocProvider(
              create: (_) => HomeNewsCubit(getIt<HomeRepository>())..getNews(),
            ),
            BlocProvider(
              create: (_) =>
                  HomeBannerCubit(getIt<HomeRepository>())..getBanners(),
            ),
          ],
          child: HomeScreen(
            onSearch: () {
              cubit.changePage(1);
            },
          ),
        ),
      ),
      NavbarItem(
        icon: Icons.search,
        label: "Search",
        pageBuilder: () => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  SearchProductHistoryCubit(getIt<SearchRepository>())
                    ..getHistory(),
            ),
            BlocProvider(
              create: (_) => SearchProductsCubit(getIt<SearchRepository>()),
            ),
          ],
          child: const SearchScreen(),
        ),
      ),
      if (FeatureFlags.enableFavorite)
        NavbarItem(
          icon: Icons.favorite,
          label: "favorite",
          pageBuilder: () => const FavoriteScreen(),
        ),
      NavbarItem(
        icon: Icons.history,
        label: "History",
        toolTip: "Order History",
        pageBuilder: () => BlocProvider(
          create: (_) =>
              OrderHistoryCubit(getIt<OrderHistoryRepository>())
                ..getOrdersHistory(),
          child: const OrderHistoryScreen(),
        ),
      ),
      NavbarItem(
        icon: Icons.person,
        label: "profile",
        pageBuilder: () => const ProfileScreen(),
      ),
    ];
  }
  void onChange(int index) {
    _loadedPages[index] ??= items[index].pageBuilder();
    if (index == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<SearchCubit>().focusNode.requestFocus();
        });
    }
  }
  bool get canPop => cubit.canPop;

  void onRefresh() {

  }

  List<Widget> get pages => _loadedPages.map((page) => page ?? const SizedBox()).toList();



}
