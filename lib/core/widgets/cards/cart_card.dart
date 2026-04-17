import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/app_chip.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/photo_overlay.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import '../../models/variant_attributes_model.dart';
import '../../theme/decorations.dart';
import '../../theme/text_styles.dart';
import '../gap.dart';
import '../quantity_stepper.dart';

class CartList extends StatelessWidget {
  final List<CartModel> cart;

  const CartList({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cart.length,
      primary: false,
      padding: EdgeInsets.zero,
      separatorBuilder: (_, i) => Divider(height: 24.h).appPaddingHr,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => CartCard(cartItem: cart[i]),
    );
  }
}

class CartCard extends StatelessWidget {
  final double height;
  final CartModel cartItem;

  const CartCard({super.key, required this.cartItem, this.height = 100});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return BaseBlocConsumer(
      bloc: cartCubit,
      builder: (_) => SizedBox(
        height: height.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(Decorations.borderRadius8.r),
              child: SizedBox(
                width: width * 0.25,
                height: height,
                child: PhotoOverlay(
                  img: cartItem.product.image,
                  title: AppChip(
                    textStyle: TextStyles.labelSmall.copyWith(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                    text:
                        (cartItem.product.price.totalPrice * cartItem.quantity)
                            .usdPrice,
                    padding: EdgeInsets.zero,
                    selected: true,
                  ),
                  titlePadding: 0,
                ),
              ),
            ),
            Gap.small(),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name ?? "",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.labelMedium,
                  ),
                  if (cartItem.product.variant != null)
                    _buildVariation(cartItem.product.variant!.attributes),
                  Gap.extraSmall(),
                  QuantityStepper.narrow(item: cartItem.product),
                ],
              ),
            ),
            AppClick(
              onTap: () => cartCubit.removeItem(cartItem.product),
              child: Icon(Icons.close, size: 18.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVariation(List<VariantsAttributes>? variants) {
    if (variants.isNullOrEmpty) return const SizedBox.shrink();
    final String variantsStr = variants!.map((e) => e.message).join("\n");
    return Text(variantsStr, maxLines: 2, overflow: TextOverflow.ellipsis);
  }
}
