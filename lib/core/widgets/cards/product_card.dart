import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import '../../../features/main/favorite/view/widgets/add_to_favorite_button.dart';
import '../../routes/routes.dart';
import '../rating_stars.dart';

class ProductGrid extends StatelessWidget {
  final bool shrinkWrap  ;
  final bool sliver  ;
  const ProductGrid({super.key,this.sliver =false ,this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    if(sliver){
     return SliverGrid(
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         crossAxisCount: 2,
         mainAxisSpacing: 21.w,
         crossAxisSpacing: 24.h,
         childAspectRatio:
         ProductCard.smallSize.aspectRatio,
       ),
       delegate: SliverChildBuilderDelegate(
             (_, __) => ProductCard.small(),
         childCount: 10,
       ),
     ) ;
    }
    return GridView.builder(
         itemCount: 4,
        shrinkWrap: shrinkWrap,
        padding: EdgeInsets.zero,
        physics: shrinkWrap ? const NeverScrollableScrollPhysics() : null,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2 ,
        crossAxisSpacing: 21.h,
        mainAxisSpacing: 24.h,
        childAspectRatio: ProductCard.smallSize.aspectRatio,
        ),
        itemBuilder: (_,__)=>  ProductCard.small());
  }
}



enum _ProductCardType {
  big,
  small;

  Size get size =>
      this == _ProductCardType.big ? const Size(double.infinity, 275) : const Size(157, 194);
}

class ProductCard extends StatelessWidget {
  final _ProductCardType _type;
  const ProductCard._({super.key, required _ProductCardType type}) : _type = type;
  factory ProductCard.big({Key? key}) => ProductCard._(key: key, type: _ProductCardType.big);
  factory ProductCard.small({Key? key}) => ProductCard._(key: key, type: _ProductCardType.small);
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
      onTap:()=>context.pushNamed(Routes.product),
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
                    const Positioned.fill(
                      child: AppCachedNetworkImage(
                        Testing.menShirt,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    _favorite(),
                    _ribbon("Best Seller", context),
                  ],
                ),
              ),
              Gap.small(),
              RatingStars(rating: 3.6, count: 12, size: isBig ? 18 : 14),
              ProductNameWithPrice(isBig:  isBig,),
              if (FeatureFlags.multiVendor) ...[
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "BY / LC Waikiki",
                      style: TextStyles.bodySmall.copyWith(
                        fontSize: isBig ? 14 : 9.sp,
                        color: context.colors.surfaceContainer,
                      ),
                    ),
                    Gap.extraSmall(),
                    CircularBox(
                      radius: isBig ? 24 : 20,
                      child: const AppCachedNetworkImage(Testing.vendor),
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
    child: AddToFavoriteButton(
      padding: isBig ? 8 : 6,
      size: isBig ? 28 : 20,
      isFavorite: true,
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
  final bool isBig ;
  const ProductNameWithPrice({super.key, this.isBig =true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            "Long Brown Sweater",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: isBig ? TextStyles.labelMedium : TextStyles.labelSmall,
          ),
        ),
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  "15.9\$",
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
              Flexible(
                flex: 2,
                child: Text(
                  "12.99\$",
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
