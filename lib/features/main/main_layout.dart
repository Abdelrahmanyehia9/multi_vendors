import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_navbar.dart';
import 'package:multi_vendor/features/main/main_layout_cubit.dart';
import 'package:multi_vendor/features/main/main_layout_mixin.dart';

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({super.key, this.initialIndex = 2});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with MainLayoutMixin {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainLayoutCubit, int>(
      listener: (_, value) {
        onChange(value);
      },
      builder: (_, value) =>
          PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) =>
                cubit.onPopScoped(
                  onConfirm: () =>
                      context.flash(
                          message: AppStrings.pressBackAgainForExit.tr()),
                  onExit: SystemNavigator.pop,
                ),
            child: BaseScaffold(
            paddingHr: 0,
            paddingVr: 0,
            topSafeArea: true,
            bottomSafeArea: false,
            bottomNavigationBar: BaseNavbar(
              items: items,
              initialIndex: value,
              onSelect: cubit.changePage,
            ),
            body: IndexedStack(
              index: value,
              children: pages,
            ),
          ),
    ),);
  }
}