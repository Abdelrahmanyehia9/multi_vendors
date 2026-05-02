import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/scaffold/sticky_bottom_layout.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:multi_vendor/features/shop/checkout/view/widgets/checkout_address_info.dart';
import 'package:multi_vendor/features/shop/checkout/view/widgets/checkout_expansion_tile.dart';
import 'package:multi_vendor/features/shop/checkout/view/widgets/checkout_shipping_info_card.dart';
import 'package:multi_vendor/features/shop/checkout/view/widgets/checkout_total_payments_summery.dart';
import 'package:multi_vendor/features/shop/checkout/view/widgets/select_payment_tile.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';
import 'package:multi_vendor/features/shop/shared/model/extension/checkout_summery_model_extension.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_list_porducts.dart';
import 'package:multi_vendor/core/utils/helper/auth_helper.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/features/payments/logic/payment_cubit.dart';
import 'package:multi_vendor/features/shop/checkout/view/mixin/checkout_mixin.dart';

class CheckoutScreenArgs{
  final CouponInfo? coupon;
  final CheckoutSummeryModel summery;
  CheckoutScreenArgs({this.coupon,
    required this.summery});

}
class CheckoutScreen extends StatefulWidget {
  final CheckoutScreenArgs args ;
  const CheckoutScreen({super.key, required this.args});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}
class _CheckoutScreenState extends State<CheckoutScreen>  with CheckoutMixin {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      paddingHr: 0,
      paddingVr: 0,
      appBar: BaseAppBar(title: "Checkout"),
      body: StickyBottomLayout(
        sticky: BaseBlocConsumer<PaymentCubit, int?>(
          bloc: paymentCubit,
          onSuccess:placeOrder,
          builder:(payStates)=>BaseBlocConsumer(
            onFailure: onOrderFailed,
            bloc: checkoutCubit,
            onSuccess: onOrderSuccess,
            builder:(orderState)=> ValueListenableBuilder(
              valueListenable: selectedOption,
              builder: (context, value, child) {
                return AppButton(
                  text: "Place an Order",
                  isLoading: orderState.isLoading || payStates.isLoading,
                  buttonSize: null,
                  enabled: value != null,
                  onPressed: () => AuthHelper.checkAuth((){
                      pay(amount: widget.args.summery.total.toDouble());
                    }, context),
                );
              }
            ),
          ),
        ),
        content: Form(
          key: formKey,
          child: Column(
            spacing: 16.h,
            children: [
              if(!userCubit.isGuest)
              const CheckoutAddressInfo(),
              _buildShippingDate(),
               _buildListProducts(),
               CheckoutExpansionTile(
                   "Payment options",
                    CheckoutPaymentOptionsList(selectedOption: selectedOption)),
              CheckoutTotalPaymentsSummery(summery: widget.args.summery ,coupon: widget.args.coupon),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShippingDate() {
    final String shipping = widget.args.summery.shippingDisplay(widget.args.coupon)??"UNKnown" ;
    return CheckoutExpansionTile("Delivery date", OrderShippingInfoCard(shipping: shipping, estimatedDelivery: estimatedDelivery));
  }
   Widget _buildListProducts() {
     return  CheckoutExpansionTile(
     "Ordered Product (${cartCubit.cartItems.length})",
     CheckoutListProducts(items: cartCubit.cartItems),
     initiallyExpanded: false,
   );
   }
}

