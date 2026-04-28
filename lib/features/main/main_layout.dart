import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_navbar.dart';
import 'package:multi_vendor/features/main/main_layout_cubit.dart';
import 'package:multi_vendor/features/main/main_layout_mixin.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({super.key, this.initialIndex = 0});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with MainLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainLayoutCubit, int>(
      listener: (_,value){onChange(value);},
      builder:(_,value)=> PopScope(
        canPop: canPop,
        onPopInvokedWithResult: (didPop, _) => cubit.onBackPressed(didPop),
        child: BaseScaffold(
          paddingHr: 0,
          paddingVr: 0,
          bottomNavigationBar: BaseNavbar(
            showLabel: true,
            items: items,
            initialIndex: value,
            onSelect: cubit.changePage,
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
      ),
    );
  }
}