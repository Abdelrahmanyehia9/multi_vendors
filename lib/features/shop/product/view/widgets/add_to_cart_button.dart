import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_product_model.dart';
import 'package:multi_vendor/features/shop/cart/logic/cart_cubit.dart';

import '../../../../../core/widgets/quantity_stepper.dart';


class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    this.enabled = true,
  });

  final CartProductModel product;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<CartCubit, List<CartModel>>(
      builder: (_) {
        if (cartCubit.inCart(product) > 0) {
          return QuantityStepper.wide(item: product);
        }
        return AppButton(
          text: 'Add To Cart',
          fixedSize: Size(double.infinity, 41.h),
          padding: EdgeInsets.zero,
          enabled: enabled,
          onPressed: () => cartCubit.addToCart(product),
          style: TextStyles.bodySmall,
          icon: Icon(Icons.shopping_bag, size: 18.sp),
          buttonSize: null,
        );
      },
    );
  }
}

