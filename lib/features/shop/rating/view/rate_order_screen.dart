import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/rating/view/widgets/list_products_to_rate_list.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class RateOrderScreen extends StatelessWidget {
  final List<CartModel> orderItems;

  const RateOrderScreen({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Product Ratings"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SectionHeader(title: "List Products"),
            ListProductsToRateList(items: orderItems),

          ],
        ),
      ),
    );
  }
}
