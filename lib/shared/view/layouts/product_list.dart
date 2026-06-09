import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/product_card.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> products;
  final bool shrinkWrap;
  final Axis scrollDirection;
  final Clip clipBehavior;
  final EdgeInsetsGeometry? padding;
  final double spacing ;

  const ProductList({
    super.key,
    this.shrinkWrap = true,
    this.spacing = 16,
    this.padding,
    this.clipBehavior = Clip.none,
    this.scrollDirection = Axis.horizontal,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) => SizedBox(
        width: spacing.w,
        height: spacing.h,
      ),
      scrollDirection: scrollDirection,
      itemCount: products.length,
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
      padding: padding ?? EdgeInsets.zero,
clipBehavior: clipBehavior,
      itemBuilder: (_, i) => ProductCard.small(product: products[i]),
    );
  }
}
