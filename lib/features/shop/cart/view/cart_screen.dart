import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/buttons/app_delete_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/sticky_bottom_layout.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/view/widgets/add_voucher_tile.dart';
import 'package:multi_vendor/features/shop/checkout/logic/checkout_summery_cubit.dart';
import 'package:multi_vendor/features/shop/checkout/view/checkout_screen.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_summery.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/shared/view/widgets/cards/cart_card.dart';
import 'package:multi_vendor/features/shop/cart/logic/cart_cubit.dart';
import 'package:multi_vendor/features/shop/cart/logic/validate_promo_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      paddingVr: 0,
      appBar: BaseAppBar(title: AppStrings.myCart.tr(), actions: [_buildAction()]),
      body: BaseBlocConsumer<CartCubit, List<CartModel>>(
        successBuilder: (cartItems) => _builder(context, cartItems: cartItems),
        emptyBuilder: AppStates.empty,
        failureBuilder: AppStates.error,
      ),
    );
  }

  Widget _builder(BuildContext context, {required List<CartModel> cartItems}) {
    return StickyBottomLayout(
      content: Column(
        children: [
          CartList(cart: cartItems),
          Gap.large(),
          const Divider(),
          if (FeatureFlags.enableVoucher) const AddVoucherTile(),
          const CheckoutSummery()
        ],
      ),
      sticky: BaseBlocConsumer(
        bloc: context.read<CheckoutSummeryCubit>(),
        builder:(s)=> AppButton(
          text: "${AppStrings.checkout.tr()} (${cartItems.length})",
          buttonSize: null,
          enabled:  s.isSuccess && cartItems.isNotEmpty,
          onPressed: () => context.pushNamed(Routes.checkout, arguments: CheckoutScreenArgs(
              summery: (s.data as CheckoutSummeryModel),
              coupon: context.read<ValidatePromoCubit>().state.data?.couponInfo

          )),
        ),
      ),
    );
  }
  Widget _buildAction() {
    return BaseBlocConsumer<CartCubit, List<CartModel>>(
        builder:(s) {
          if(s.isEmpty) return const SizedBox.shrink();
          return AppDeleteButton(onTap: cartCubit.clearCart,);
        }
        );
  }
}
