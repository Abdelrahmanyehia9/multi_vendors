import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/view/widgets/quantity_stepper.dart';

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
            AppClick(
              onTap: ()=>context.pushNamed(Routes.product, arguments: cartItem.product.id),
              child: AppCachedNetworkImage(
                  width: width*.25,
                  height: height,
                  radius: Decorations.borderRadius16,
                  cartItem.product.image),
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
                  Text("Total: ${cartItem.total.usdPrice}"),
                  Gap.small(),
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

}
