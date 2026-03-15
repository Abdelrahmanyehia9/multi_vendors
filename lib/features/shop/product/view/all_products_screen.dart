import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/app_chip.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/product/view/widgets/product_filters_action.dart';

import '../../../../../core/widgets/cards/product_card.dart';
import '../../../../../core/widgets/scaffold/base_appbar.dart';

class AllProductsScreen extends StatelessWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(
        title: "all products",
        actions:  const [
          ProductFiltersAction(),
        ],
      ),
      body: Column(
        spacing: 12.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterChips(["men", "to 500 EGP", "from 20 EGP", "formal", ]),
          const Expanded(
            child: ProductGrid(
            ),
          ),
        ],
      ).appPaddingHr,
    );
  }
  Widget _buildFilterChips(List<String> filters)=> Wrap(
    spacing: 4.h,
    children: List.generate(filters.length, (i) =>  AppChip(text: filters[i].toUpperCase(), selected: true,)),
  ) ;
}
