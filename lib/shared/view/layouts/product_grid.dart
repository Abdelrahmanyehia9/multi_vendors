import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';

class ProductGrid extends StatelessWidget {
  final bool shrinkWrap;

  final bool sliver;

  final List<ProductModel> products;

  const ProductGrid({
    super.key,
    this.sliver = false,
    this.shrinkWrap = false,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (sliver) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.w,
          crossAxisSpacing: 16.h,
          childAspectRatio: ProductCard.smallSize.aspectRatio,
        ),
        delegate: SliverChildBuilderDelegate(
              (_, i) => ProductCard.small(product: products[i]),
          childCount: products.length,
        ),
      );
    }
    return GridView.builder(
      itemCount: products.length,
      shrinkWrap: shrinkWrap,
      padding: EdgeInsets.zero,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.w,
        crossAxisSpacing: 16.h,
        childAspectRatio: ProductCard.smallSize.aspectRatio,
      ),
      itemBuilder: (_, i) => ProductCard.small(product: products[i]),
    );
  }
}
