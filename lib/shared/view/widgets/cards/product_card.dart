import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/main/favorite/view/widgets/app_favorite_button.dart';
import 'package:multi_vendor/shared/data/models/price_model.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';
import 'package:multi_vendor/shared/view/widgets/rating_stars.dart';

enum _ProductCardType {
  big,
  small;

  Size get size => this == _ProductCardType.big
      ? const Size(double.infinity, 350)
      : const Size(160, 250);
}

class ProductCard extends StatelessWidget {
  final _ProductCardType _type;
  final ProductModel product;
  final bool showVendor ;

  const ProductCard._({
    super.key,
    required this.product,
    this.showVendor = true,
    required _ProductCardType type,
  }) : _type = type;

  factory ProductCard.big({Key? key, required ProductModel product , bool showVendor = true}) =>
      ProductCard._(key: key, type: _ProductCardType.big, product: product, showVendor: showVendor);

  factory ProductCard.small({Key? key, required ProductModel product, bool showVendor = true}) =>
      ProductCard._(key: key, type: _ProductCardType.small, product: product, showVendor: showVendor,);

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
      onTap: () => context.pushNamed(Routes.product, arguments: product),
      child: Stack(
        children: [
          Container(
            width: w,
            height: h,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color:
                      (product.sponsored ? Colors.transparent : AppColors.grey)
                          .withAppOpacity(0.075),
                  blurRadius: 10,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
              border: product.vendor?.isSponsored == true
                  ? Border.all(color: AppColors.gold, width: 1.25.sp)
                  : null,
              color: context.scaffoldBackground,
              borderRadius: BorderRadius.circular(Decorations.borderRadius12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * .6,
                  width: w,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Positioned.fill(
                        child: AppCachedNetworkImage(
                          product.thumbnail,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      if (product.id != null) _favorite(),
                      if (product.ribbon != null)
                        _ribbon(
                          product.ribbon!.toText,
                          context,
                          color: product.ribbon!.color,
                        ),
                    ],
                  ),
                ),
                Gap.small(),
                if (product.rating != null)
                  RatingStars(
                    rating: product.rating,
                    size: isBig ? 18 : 14,
                  ).paddingHr(isBig ? 16 : 12).paddingVr(isBig ? 4 : 2),
                ProductNameWithPrice(
                  size: isBig? 16.sp:12.sp,
                  price: product.price,
                  name: product.name.localized,
                ).paddingHr(isBig ? 16 : 12),
                if (isBig && product.description != null)
                  Text(
                    product.description!.localized,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.captionSmall.copyWith(
                      color: context.colors.surfaceContainer,
                    ),
                  ).paddingHr(isBig ? 16 : 12),
                if (FeatureFlags.multiVendor && product.vendor != null && showVendor) ...[
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        product.vendor!.name.localized.toUpperCase(),
                        style: TextStyles.bodySmall.copyWith(
                          fontSize: isBig ? 14.sp : 10.sp,
                          color: context.colors.surfaceContainer,
                        ),
                      ),
                      Gap.extraSmall(),
                      CircularBox(
                        radius: isBig ? 26 : 24,
                        child: AppCachedNetworkImage(product.vendor!.image),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ],
            ),
          ),
          if (product.sponsored)
            _ribbon(
              AppStrings.featured.tr(),
              align: AlignmentDirectional.bottomStart,
              context,
              borderRadius: BorderRadius.circular(Decorations.borderRadius8),
              color: AppColors.gold.darken(0.25),
            ),
        ],
      ),
    );
  }

  Widget _favorite() => AppFavoriteButton(
    item: product,
    size: isBig ? 18 : 16,
    radius: isBig ? 8 : 6,
  );

  Widget _ribbon(
    String text,
    BuildContext context, {
    Color? color,
    BorderRadiusGeometry? borderRadius,
    AlignmentDirectional align = AlignmentDirectional.topStart,
  }) {
    final r = Radius.circular(Decorations.borderRadius16.r);
    final rtl = Directionality.of(context) == TextDirection.rtl;
    return Align(
      alignment: align,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isBig ? 12.w : 8.w,
          vertical: isBig ? 4.h : 2.h,
        ),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius:
              borderRadius ??
              BorderRadius.only(
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
  final String name;
  final double size ;
  final PriceModel? price;
  final int? maxLines;

  const ProductNameWithPrice({
    super.key,
    required this.name,
    this.price,
     this.size = 16,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: size*.6,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: maxLines,
            overflow:maxLines==null ? null : TextOverflow.ellipsis,
            style: TextStyles.labelMedium.copyWith(
              fontSize: size
            ),
          ),
        ),
        if (price != null)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (price!.isOnSale) ...[
                Text(
                  price!.priceBeforeDiscount!.usdPrice,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.bodySmall.copyWith(
                    color: context.colors.surfaceContainer,
                    fontSize: size*.8,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: context.colors.surfaceContainer,
                    decorationThickness: 1.sp,
                  ),
                ),
                Gap(size*.2),
              ],
              Text(
                price!.totalPrice.usdPrice,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.labelMedium.copyWith(
                  color: AppColors.primary,
                  fontSize: size*.9,
                  fontWeight: FontWeightHelper.bold,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
