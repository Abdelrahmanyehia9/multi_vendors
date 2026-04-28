import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/widgets/buttons/app_favorite_button.dart';
import 'package:multi_vendor/shared/data/models/price_model.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/rating_stars.dart';

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
          mainAxisSpacing: 21.w,
          crossAxisSpacing: 24.h,
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
        crossAxisSpacing: 21.h,
        mainAxisSpacing: 24.h,
        childAspectRatio: ProductCard.smallSize.aspectRatio,
      ),
      itemBuilder: (_, i) => ProductCard.small(product: products[i]),
    );
  }
}

enum _ProductCardType {
  big,
  small;

  Size get size => this == _ProductCardType.big
      ? const Size(double.infinity, 275)
      : const Size(157, 194);
}

class ProductCard extends StatelessWidget {
  final _ProductCardType _type;
  final ProductModel product;

  const ProductCard._({
    super.key,
    required this.product,
    required _ProductCardType type,
  }) : _type = type;

  factory ProductCard.big({Key? key, required ProductModel product}) =>
      ProductCard._(key: key, type: _ProductCardType.big, product: product);

  factory ProductCard.small({Key? key, required ProductModel product}) =>
      ProductCard._(key: key, type: _ProductCardType.small, product: product);
  static Size get bigSize => _ProductCardType.big.size;
  static Size get smallSize => _ProductCardType.small.size;
  bool get isBig => _type == _ProductCardType.big;
  Size get cardSize => _type.size;

  @override
  Widget build(BuildContext context) {
    final size = cardSize;
    final w = size.width.w;
    final h = size.height.h;

    return AppClick(
      onTap: () => context.pushNamed(Routes.product, arguments: product.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
        child: SizedBox(
          width: w,
          height: h,
          child: Column(
            children: [
              SizedBox(
                height: h * .575,
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Positioned.fill(
                      child: AppCachedNetworkImage(
                        product.thumbnail,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    if(product.id!=null)
                    _favorite(),
                    if(!product.productTags.isNullOrEmpty)
                    _ribbon(product.productTags!.first.toText, context
                    , color: product.productTags!.first.color,
                    ),
                  ],
                ),
              ),
              Gap.small(),
              if (product.rating != null)
                RatingStars(
                  rating: product.rating,
                  size: isBig ? 18 : 14,
                ),
              ProductNameWithPrice(
                isBig: isBig,
                price: product.price,
                name: product.name!,
              ),
              if (FeatureFlags.multiVendor && product.vendor != null) ...[
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "BY / ${product.vendor!.name}",
                      style: TextStyles.bodySmall.copyWith(
                        fontSize: isBig ? 14 : 9.sp,
                        color: context.colors.surfaceContainer,
                      ),
                    ),
                    Gap.extraSmall(),
                    CircularBox(
                      radius: isBig ? 24 : 20,
                      child: AppCachedNetworkImage(product.vendor!.image),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _favorite() => Align(
    alignment: AlignmentDirectional.topEnd,
    child: AppFavoriteButton(
      item: product,
      padding: isBig ? 12 : 8,
      size: isBig ? 28 : 20,
    ),
  );
  Widget _ribbon(String text, BuildContext context, {Color? color}) {
    final r = Radius.circular(Decorations.borderRadius16.r);
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isBig ? 12.w : 8.w,
          vertical: isBig ? 4.h : 2.h,
        ),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: rtl ? Radius.zero : r,
            bottomLeft: rtl ? r : Radius.zero,
            topRight: rtl ? r : Radius.zero,
            bottomRight: rtl ? Radius.zero : r,
          ),
        ),
        child: Text(
          text,
          style: TextStyles.bodySmall.copyWith(
            color: AppColors.white,
            fontSize: isBig ? 14.sp : 10.sp,
          ),
        ),
      ),
    );
  }
}

class ProductNameWithPrice extends StatelessWidget {
  final bool isBig;
  final String name;
  final PriceModel? price;

  const ProductNameWithPrice({
    super.key,
    required this.name,
    this.price,
    this.isBig = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: isBig ? TextStyles.labelMedium : TextStyles.labelSmall,
          ),
        ),
        if (price != null)
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (price!.salePrice != null) ...[
                  Flexible(
                    child: Text(
                      price!.totalPrice.usdPrice,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.captionSmall.copyWith(
                        color: context.colors.surfaceContainer,
                        fontSize: isBig ? 12.sp : 10.sp,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: context.colors.surfaceContainer,
                        decorationThickness: 4,
                      ),
                    ),
                  ),
                  Gap(isBig ? 8 : 4),
                ],
                Flexible(
                  flex: 2,
                  child: Text(
                    price!.totalPrice.usdPrice,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.labelMedium.copyWith(
                      color: AppColors.primary,
                      fontSize: isBig ? 14.sp : 11.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
