import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/service/notification/notification_service.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_navbar.dart';
import 'package:multi_vendor/features/main/category/data/repository/category_repository.dart';
import 'package:multi_vendor/features/main/category/logic/main_categories_cubit.dart';
import 'package:multi_vendor/features/main/category/view/category_screen.dart';
import 'package:multi_vendor/features/main/favorite/view/favorite_screen.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/features/main/home/logic/home_banner_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_featured_item_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_news_arrivals_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_news_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_on_going_order_cubit.dart';
import 'package:multi_vendor/features/main/home/logic/home_product_by_sub_category_cubit.dart';
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
import 'package:multi_vendor/shared/logic/search_cubit.dart';
import 'package:multi_vendor/features/main/category/logic/sub_categories_cubit.dart';

mixin MainLayoutMixin on State<MainLayout> {
  MainLayoutCubit get cubit => context.read<MainLayoutCubit>()  ;
  late final List<NavbarItem> items;
  late final List<Widget?> _loadedPages;


  @override
  void initState() {
    super.initState();
    NotificationService.instance.login(userCubit.user?.id);
    items = _buildItems();
    _loadedPages = List.generate(items.length, (_) => null);
    _loadedPages[widget.initialIndex] = items[widget.initialIndex]
        .pageBuilder();
  }

  List<NavbarItem> _buildItems() {
    return [
      NavbarItem(
        icon: MvIcons.home,
        label: AppStrings.home.tr(),
        pageBuilder: () => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
              SubCategoriesCubit(getIt<CategoryRepository>())..getSubCategories(),
            ),
            BlocProvider(
              create: (_) =>
              HomeNewsArrivalsCubit(getIt<HomeRepository>())..getNewsArrivals(),
            ),
            BlocProvider(
              create: (_) =>
              HomeVendorsCubit(getIt<HomeRepository>())..getAllVendors(),
            ),
            BlocProvider(
              create: (_) =>
                  HomeProductBySubCategoryCubit(getIt<HomeRepository>()),
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
            BlocProvider(
              create: (_) =>
              HomeOnGoingOrderCubit(getIt<HomeRepository>())..getOnGoing(),
            ),
          ],
          child: const HomeScreen(),
        ),
      ),
      NavbarItem(
        icon: MvIcons.category,
        label: AppStrings.categories.tr(),
        toolTip: AppStrings.categories.tr(),
        pageBuilder: () => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context)=>SearchCubit(autoFocus: false)),
              BlocProvider(create: (context)=> MainCategoriesCubit(getIt.get<CategoryRepository>())..getCategories()),
              BlocProvider(create: (context)=> SubCategoriesCubit(getIt.get<CategoryRepository>()))
            ],
            child: const CategoryScreen())
      ),
      NavbarItem(
        icon: MvIcons.search,
        label: AppStrings.search.tr(),
        pageBuilder: () => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SearchCubit()),
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
          icon: MvIcons.favoriteOutlined,
          label: AppStrings.favorites.tr(),
          pageBuilder: () => const FavoriteScreen(),
        ),

      NavbarItem(
        icon: MvIcons.user,
        label: AppStrings.profile.tr(),
        pageBuilder: () => const ProfileScreen(),
      ),
    ];
  }
  void onChange(int index) {
    _loadedPages[index] ??= items[index].pageBuilder();
  }
  List<Widget> get pages => _loadedPages
      .map((p) => p ?? const SizedBox.shrink()
  )
      .toList();

}
