import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';


enum QuantityStepperStyle {wide, narrow}

class _AddOrMinusArgs {
  const _AddOrMinusArgs({
    required this.quantity,
    required this.addEnabled,
    required this.minusEnabled,
    required this.onAdd,
    required this.onMinus,
  });

  final int quantity;
  final bool addEnabled;
  final bool minusEnabled;
  final VoidCallback onAdd;
  final VoidCallback onMinus;
}
class QuantityStepper extends StatelessWidget {
  final QuantityStepperStyle style;
  final ProductModel product;
  const QuantityStepper._({super.key,required this.style, required this.product});

  factory QuantityStepper.wide({required ProductModel item,Key? key}) =>
      QuantityStepper._(style: QuantityStepperStyle.wide, key: key, product: item);

  factory QuantityStepper.narrow({required ProductModel item, Key? key}) =>
      QuantityStepper._(style: QuantityStepperStyle.narrow, key:key , product: item);


  @override
  Widget build(BuildContext context) {
        final int inCart = cartCubit.inCart(product);
        final remining = product.inStock - inCart ;
        final bool isNarrow = style == QuantityStepperStyle.narrow;
        final args = _AddOrMinusArgs(
          quantity: inCart,
          addEnabled: remining > 0,
          minusEnabled: inCart > 0,
          onAdd: () => cartCubit.updateQuantity(true, item: product),
          onMinus: () => cartCubit.updateQuantity(false, item: product),
        );
        return Column(
          spacing: isNarrow? 4.h : 8.h,
          children: [
            style == QuantityStepperStyle.narrow
                ? _NarrowAddOrMinus(args)
                : _WideAddOrMinus(args),
            if (remining > 0  && remining < 10)
            Text('$remining ${AppStrings.itemsLeft.tr()}',style: TextStyles.labelMedium.copyWith(
              color: AppColors.error,
              fontSize: isNarrow? 12.sp : 14.sp
            ),)
          ],
        );
  }
}

class _NarrowAddOrMinus extends StatelessWidget {
  const _NarrowAddOrMinus(this._args);

  final _AddOrMinusArgs _args;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CircleButton(icon: MvIcons.add, onTap: _args.onAdd, enabled: _args.addEnabled),
          Text(_args.quantity.toString(), style: TextStyles.labelSmall).appPaddingHr,
          _CircleButton(icon: MvIcons.remove, onTap: _args.onMinus, enabled: _args.minusEnabled),

        ],
      ),
    );
  }
}
class _WideAddOrMinus extends StatelessWidget {
  const _WideAddOrMinus(this._args);

  final _AddOrMinusArgs _args;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppIconButton(
          enabled: _args.addEnabled,
          icon: MvIcons.add,
          onTap: _args.onAdd,
        ),
        Text(_args.quantity.toString(), style: TextStyles.labelLarge),
        AppIconButton(
          enabled: _args.minusEnabled,
          icon: MvIcons.remove,
          onTap: _args.onMinus,
        ),
      ],
    );
  }
}class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.onTap,
    required this.enabled,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return AppClick(
      onTap: enabled ? onTap : null,
      child: CircleAvatar(
        radius: 12.r,
        backgroundColor: enabled ?  AppColors.primary:context.colors.surfaceContainerLow,
        child: Icon(icon, size: 12.sp, color: enabled? AppColors.white: context.colors.surfaceContainer),
      ),
    );
  }
}



