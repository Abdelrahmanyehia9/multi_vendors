import 'package:flutter/material.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/utils/feature_flags.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/sticky_bottom_layout.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/view/widgets/add_voucher_tile.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/cards/cart_card.dart';
import '../../../../core/widgets/cards/order_cards.dart';
import '../../../../core/widgets/gap.dart';
import '../../../../core/widgets/scaffold/base_scaffold.dart';
import '../logic/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      paddingVr: 0,
      appBar: BaseAppBar(
        title: "My Cart",
        actions: const [AppIconButton(icon: Icons.delete)],
      ),
      body: BaseBlocConsumer<CartCubit,List<CartModel>>(
        successBuilder: (cartItems)=>_builder(context,cartItems:  cartItems),
        emptyBuilder: AppStates.empty,
        failureBuilder: AppStates.error,
      )
    );
  }


  Widget _builder(BuildContext context, {required List<CartModel> cartItems}){
    return StickyBottomLayout(
        content: Column(
          children: [
             CartList(cart: cartItems),
            Gap.large(),
            const Divider(),
            if(FeatureFlags.enableVoucher)
              const AddVoucherTile(),
            const OrderReceiptCard(),
          ],
        ),
        sticky: AppButton(
          text: "Checkout (${cartItems.length})",
          buttonSize: null,
          onPressed: () => context.pushNamed(Routes.checkout),
        )
    ) ;
  }
}