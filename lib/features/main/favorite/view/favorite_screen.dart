import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/cards/product_card.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_tab_bar.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/scaffold/base_appbar.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> with SingleTickerProviderStateMixin{
  late final TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 90.h,
          child: BaseAppBar(
            title: "Favorite",
          ),
        ),
         if(AppConstants.multiVendor)...[
           BaseTabBar(
             alignment: TabAlignment.center,
             controller: controller, tabs: ["Products", "Vendors"],),
           Gap.large(),
           Expanded(
               child: TabBarView(
                   controller: controller,
                   children: [
                     const ProductGrid().appPaddingHr,
                     const ProductGrid().appPaddingHr,
                   ]
               ))
         ]else
           Expanded(child: const ProductGrid().appPaddingHr)

      ],
    ) ;
  }

}
