import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/section_header.dart';

class CheckoutListProducts extends StatelessWidget {
  final bool showHeader ;
  final List<CartModel> items ;
  const CheckoutListProducts({super.key,required this.items ,this.showHeader =false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(showHeader)  SectionHeader(title: AppStrings.orderedProducts.tr()),
        ListView.separated(
          itemCount: items.length,
          primary: false,
          padding: EdgeInsets.zero,
          separatorBuilder: (_,i)=>Gap.medium()  ,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_,i)=> CheckoutProductCard(item: items[i],),
        ),
      ],
    );
  }
}

class CheckoutProductCard extends StatelessWidget {
  final double height ;
  final Widget? customAction;
  final CartModel item ;
  final GestureTapCallback? onTap  ;
  const CheckoutProductCard({super.key, this.onTap,required this.item ,this.customAction,this.height = 70});

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: onTap ?? ()=> context.pushNamed(Routes.product, arguments: item.product.id),
        child: Row(
          children: [
            AppCachedNetworkImage(
              item.product.thumbnail,
              height: height,
              width: context.width*.25,
              radius: Decorations.borderRadius8,
            ),
            Gap.small(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name.localized,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.labelMedium.copyWith(
                      fontSize: (height*.215).sp
                    ),
                  ),
                  Text(
                    "${AppStrings.total.tr()} : ${item.total.usdPrice}",
                    maxLines: 1,
                    style: TextStyles.captionMedium.copyWith(
                      fontSize: (height*.185).sp
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (customAction != null)
              customAction!
            else
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: context.width*.25,
                  minWidth: context.width*.1
                ),
                child: Text(
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  item.quantity == 1 ? "" : "x${item.quantity}",
                  style: TextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontSize: (height*.2).sp
                  ),
                ).paddingHr(8),
              ),
          ],
        )
    );

  }

}


