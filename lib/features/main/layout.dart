import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/base_scaffold.dart';
import '../../core/widgets/app_navbar.dart';
import 'home/view/home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<NavbarItem>items = [
    NavbarItem(icon: Icons.home, label: "Home", page: const HomeScreen()),
    NavbarItem(icon: Icons.search, label: "Search", page: const SizedBox()),
    NavbarItem(icon: Icons.shopping_bag, label: "cart",page: const SizedBox()),
    NavbarItem(icon: Icons.favorite, label: "favorite", page: const SizedBox()),
    NavbarItem(icon: Icons.person, label: "profile", page: const SizedBox()),

  ] ;
  final ValueNotifier<int> _selectedPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return  BaseScaffold(
      bottomNavigationBar: AppNavbar(
        items: items,
        initialIndex: _selectedPage.value,
        onSelect: (newItem){
          _selectedPage.value = newItem ;
        },
      ),
      body: ValueListenableBuilder(
        valueListenable: _selectedPage,
        builder: (context, value, child) {
          return items[value].page;
        }
      ),
    );
  }
}
