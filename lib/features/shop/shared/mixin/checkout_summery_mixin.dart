import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/features/shop/shared/widgets/checkout_summery.dart';
import 'package:flutter/material.dart';

import '../../../../core/DI/setup_get_it.dart';
import '../../cart/logic/validate_promo_cubit.dart';
import '../../checkout/logic/checkout_summery_cubit.dart';


mixin CheckoutSummeryMixin on State<CheckoutSummery> {

  @override
  void initState() {
    calculateCheckout();
    super.initState();
  }

  Future<void>calculateCheckout()async{
    final voucher = context.read<ValidatePromoCubit>().state ;
    context.read<CheckoutSummeryCubit>().calculateSummery(
      cartCubit.cartItems,
      code: voucher.isSuccess && voucher.data?.valid == true ? voucher.data?.couponInfo?.code : null,
    );

  }


}