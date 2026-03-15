import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/main/profile/view/profile_screen.dart';
import '../../core/widgets/scaffold/base_navbar.dart';
import 'favorite/view/favorite_screen.dart';
import 'home/view/home_screen.dart';

class MainLayout extends StatefulWidget {
  final int initially;
  const MainLayout({super.key, this.initially = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<NavbarItem> items = [
    NavbarItem(icon: Icons.home, label: "Home", page: const HomeScreen()),
    NavbarItem(icon: Icons.search, label: "Search", page: const SizedBox()),
    NavbarItem(icon: Icons.favorite, label: "favorite", page: const FavoriteScreen()),
    NavbarItem(icon: Icons.history, label: "History", page: const SizedBox(), toolTip: "Order History"),
    NavbarItem(icon: Icons.person, label: "profile", page: const ProfileScreen()),
  ];

  final ValueNotifier<int> _selectedPage = ValueNotifier(0);

  @override
  void initState() {
    _selectedPage.value = widget.initially;
    super.initState();
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
          bottomNavigationBar: BaseNavbar(
            key: ValueKey(value),
            showLabel: true,
            items: items,
            initialIndex: value,
            onSelect: (newItem) => _selectedPage.value = newItem,
          ),
          body: items[value].page,
        ),
      ),
    );
  }
}