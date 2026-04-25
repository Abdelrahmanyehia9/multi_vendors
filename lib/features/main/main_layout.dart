import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import '../../core/widgets/scaffold/base_navbar.dart';
import 'main_layout_mixin.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with MainLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedPage,
      builder: (context, value, child) {
        return PopScope(
          canPop: canPop,
          onPopInvokedWithResult: (didPop, _) => onBackPressed(didPop),
          child: BaseScaffold(
            paddingHr: 0,
            paddingVr: 0,
            bottomNavigationBar: BaseNavbar(
              showLabel: true,
              items: items,
              initialIndex: value,
              onSelect: changePage,
            ),
            body: RefreshIndicator(
              elevation: 5,
              onRefresh: ()async{
                onRefresh();
              },
              child: IndexedStack(
                index: value,
                children: pages,
              ),
            ),
          ),
        );
      },
    );
  }
}