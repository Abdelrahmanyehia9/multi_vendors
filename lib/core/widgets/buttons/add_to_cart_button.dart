import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/logic/cart_cubit.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';
import 'package:multi_vendor/shared/view/widgets/quantity_stepper.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';


class AddToCartButton extends StatelessWidget {
  const AddToCartButton({
    super.key,
    required this.product,
    this.enabled = true,
  });

  final ProductModel product;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return BaseBlocConsumer<CartCubit, List<CartModel>>(
      builder: (_) {
        if (cartCubit.inCart(product) > 0) {
          return QuantityStepper.wide(item: product);
        }
        return AppButton(
          text: AppStrings.addToCart.tr(),
          fixedSize: Size(double.infinity, 41.h),
          padding: EdgeInsets.zero,
          enabled: enabled,
          onPressed: () => cartCubit.addToCart(product),
          style: TextStyles.bodyMedium,
          icon: Icon(MvIcons.shopping, size: 18.sp),
          buttonSize: null,
        );
      },
    );
  }
}

