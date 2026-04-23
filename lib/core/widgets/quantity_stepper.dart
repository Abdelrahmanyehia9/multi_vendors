import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import '../../features/shop/cart/data/models/cart_model.dart';
import '../DI/setup_get_it.dart';
import '../theme/app_colors.dart';
import '../theme/decorations.dart';
import '../theme/text_styles.dart';
import 'app_click.dart';
import 'buttons/app_icon_button.dart';

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
  const QuantityStepper._({required this.style, required this.product});

  factory QuantityStepper.wide({required CartProductModel item}) =>
      QuantityStepper._(style: QuantityStepperStyle.wide, product: item);

  factory QuantityStepper.narrow({required CartProductModel item}) =>
      QuantityStepper._(style: QuantityStepperStyle.narrow, product: item);

  final CartProductModel product;

  @override
  Widget build(BuildContext context) {
        final int inCart = cartCubit.inCart(product);
        final args = _AddOrMinusArgs(
          quantity: inCart,
          addEnabled: true,
          minusEnabled: inCart > 0,
          onAdd: () => cartCubit.updateQuantity(true, item: product),
          onMinus: () => cartCubit.updateQuantity(false, item: product),
        );
        return style == QuantityStepperStyle.narrow
            ? _NarrowAddOrMinus(args)
            : _WideAddOrMinus(args);
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
          _CircleButton(icon: Icons.remove, onTap: _args.onMinus, enabled: _args.minusEnabled),
          Text(_args.quantity.toString(), style: TextStyles.labelSmall).appPaddingHr,
          _CircleButton(icon: Icons.add, onTap: _args.onAdd, enabled: _args.addEnabled),
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
          enabled: _args.minusEnabled,
          icon: Icons.remove,
          onTap: _args.onMinus,
        ),
        Text(_args.quantity.toString(), style: TextStyles.labelLarge),
        AppIconButton(
          enabled: _args.addEnabled,
          icon: Icons.add,
          onTap: _args.onAdd,
        ),
      ],
    ).appPaddingVr;
  }
}
class _CircleButton extends StatelessWidget {
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



