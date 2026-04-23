import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/features/shop/checkout/view/checkout_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enum/payment_option.dart';
import '../../../../../core/utils/helper/payment_helper.dart';
import '../../../../payments/logic/payment_cubit.dart';
import '../../../shared/model/order_model.dart';
import '../../data/model/checkout_request.dart';
import '../../logic/checkout_cubit.dart';

mixin CheckoutMixin on State<CheckoutScreen> {
  final formKey = GlobalKey<FormState>();
  final selectedOption = ValueNotifier<PaymentOption?>(null);
  final DateTime estimatedDelivery = DateTime.now().add(const Duration(days: 3)) ;
  PaymentCubit get paymentCubit => context.read<PaymentCubit>();
  CheckoutCubit get checkoutCubit => context.read<CheckoutCubit>();
  int? payId;

  Future<void> pay({required double amount})async{
    if(formKey.currentState!.validate() ){
      final strategy = PaymentHelper.instance.fromOption(selectedOption.value!);
     paymentCubit.payment(
         strategy:strategy,
         amount: amount);
    }
  }
  Future<void> placeOrder(int? id)async{
    payId = id;
    if(payId == null) return;
    checkoutCubit.placeAnOrder(
      CheckoutRequest(
        coupon: widget.args.coupon?.code,
        items:  cartCubit.cartItems,
        address: userCubit.user?.address,
        summery: widget.args.summery,
        paymentId: payId!,
        estimatedDelivery: estimatedDelivery,
      )
    );
  }
  void onOrderFailure(AppException e){
    context.errorBar(message: e.message) ;
    paymentCubit.deletePayment(paymentId: payId!);
  }
  void onOrderSuccess(OrderModel? model){
    if(model ==null ) return ;
    cartCubit.clearCart() ;
    context.pushReplacementNamed(Routes.orderSuccess , arguments: model) ;
  }



  @override
  void dispose() {
    selectedOption.dispose();
    super.dispose();
  }

}