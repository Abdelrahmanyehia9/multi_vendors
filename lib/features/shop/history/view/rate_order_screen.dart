import 'package:flutter/material.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/shop/history/view/widgets/list_products_to_rate_list.dart';
import '../../../../core/widgets/section_header.dart';

class RateOrderScreen extends StatelessWidget {
  const RateOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: BaseAppBar(title: "Product Ratings"),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SectionHeader(title: "List Products"),
            ListProductsToRateList(),
          ],
        ),
      )
    );
  }
}
