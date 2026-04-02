import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/home/data/repository/home_repository.dart';
import 'package:multi_vendor/features/main/profile/view/profile_screen.dart';
import 'package:multi_vendor/features/main/search/view/search_screen.dart';
import '../../core/cubit/search_cubit.dart';
import '../../core/widgets/scaffold/base_navbar.dart';
import '../shop/history/view/order_history_screen.dart';
import 'favorite/view/favorite_screen.dart';
import 'home/logic/home_banner_cubit.dart';
import 'home/logic/home_cateogries_logic.dart';
import 'home/logic/home_featured_item_cubit.dart';
import 'home/logic/home_news_cubit.dart';
import 'home/logic/home_product_by_category_cubit.dart';
import 'home/logic/home_tags_filter_cubit.dart';
import 'home/logic/home_vendors_cubit.dart';
import 'home/view/home_screen.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final ValueNotifier<int> _selectedPage = ValueNotifier(0);
  late final List<NavbarItem> items;

  @override
  void initState() {
    super.initState();
    items = [
      NavbarItem(
        icon: Icons.home,
        label: "Home",
        page: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  HomeCategoriesCubit(getIt.get<HomeRepository>())
                    ..getCategories(),
            ),
            BlocProvider(
              create: (context) =>
                  HomeVendorsCubit(getIt.get<HomeRepository>())
                    ..getAllVendors(),
            ),
            BlocProvider(
              create: (context) =>
                  HomeProductByCategoryCubit(getIt.get<HomeRepository>()),
            ),
            BlocProvider(
              create: (context) =>
                  HomeFeaturedItemCubit(getIt.get<HomeRepository>())
                    ..getFeaturedItem(),
            ),
            BlocProvider(
              create: (context) =>
                  HomeTagsFilterCubit(getIt.get<HomeRepository>())..getTags(),
            ),
            BlocProvider(
              create: (context) =>
                  HomeNewsCubit(getIt.get<HomeRepository>())..getNews(),
            ),
            BlocProvider(
              create: (context) =>
                  HomeBannerCubit(getIt.get<HomeRepository>())..getBanners(),
            ),
          ],
          child: HomeScreen(onSearch: () => _selectedPage.value = 1),
        ),
      ),
      NavbarItem(
        icon: Icons.search,
        label: "Search",
        page: BlocProvider(
          create: (context) => SearchCubit(),
          child: const SearchScreen(),
        ),
      ),
      NavbarItem(
        icon: Icons.favorite,
        label: "favorite",
        page: const FavoriteScreen(),
      ),
      NavbarItem(
        icon: Icons.history,
        label: "History",
        page: const OrderHistoryScreen(),
        toolTip: "Order History",
      ),
      NavbarItem(
        icon: Icons.person,
        label: "profile",
        page: const ProfileScreen(),
      ),
    ];
    _selectedPage.value = widget.initialIndex;
  }

  @override
  void dispose() {
    _selectedPage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _selectedPage,
      builder: (context, value, child) => PopScope(
        canPop: value == 0,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _selectedPage.value = 0;
        },
        child: BaseScaffold(
          paddingHr: 0,
          paddingVr: 0,
          bottomNavigationBar: BaseNavbar(
            key: ValueKey(value),
            showLabel: true,
            items: items,
            initialIndex: value,
            onSelect: (newItem) => _selectedPage.value = newItem,
          ),
          body: IndexedStack(
            index: value,
            children: items.map((item) => item.page).toList(),
          ),
        ),
      ),
    );
  }
}
