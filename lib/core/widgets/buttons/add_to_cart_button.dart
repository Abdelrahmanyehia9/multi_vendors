import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/di/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
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
        final inCart = cartCubit.inCart(product) > 0;
        return AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: ScaleTransition(scale: animation, child: child),
            ),
            child: inCart
                ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12.w,
                  children: [
                    Expanded(
                      child: QuantityStepper.wide(
                                    key: const ValueKey('stepper'),
                                    item: product,
                                  ),
                    ),
                    AppButton(text: AppStrings.viewCart.tr(),
                      onPressed: ()=>context.pushNamed(Routes.cart),
                      buttonSize: null,

                    ) ,

                  ],
                )
                : AppButton(
              key: const ValueKey('button'),
              text: AppStrings.addToCart.tr(),
              fixedSize: const Size(double.infinity, 44),
              padding: EdgeInsets.zero,
              enabled: enabled,
              onPressed: () => cartCubit.addToCart(product),
              style: TextStyles.bodyMedium,
              icon: Icon(MvIcons.shopping, size: 18.sp),
              buttonSize: null,
            ),
          ),
        );
      },
    ).appPaddingVr;
  }
}

