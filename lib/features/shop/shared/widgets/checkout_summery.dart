import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/DI/setup_get_it.dart';
import '../../../../core/cubit/base_bloc_consumer.dart';
import '../../../../core/cubit/base_state.dart';
import '../../../../core/widgets/cards/order_cards.dart';
import '../../cart/data/models/cart_model.dart';
import '../../cart/data/models/promo_code_model.dart';
import '../../cart/logic/cart_cubit.dart';
import '../../cart/logic/validate_promo_cubit.dart';
import '../../checkout/logic/checkout_summery_cubit.dart';
import '../model/checkout_model.dart';

class CheckoutSummery extends StatefulWidget {
  const CheckoutSummery({super.key});

  @override
  State<CheckoutSummery> createState() => _CheckoutSummeryState();
}

class _CheckoutSummeryState extends State<CheckoutSummery> {


  @override
  void initState() {
    _calculateCheckout();
    super.initState();
  }

  Future<void>_calculateCheckout()async{
    final voucher = context.read<ValidatePromoCubit>().state ;
    context.read<CheckoutSummeryCubit>().calculateSummery(
      cartCubit.cartItems,
      code: voucher.isSuccess && voucher.data?.valid == true ? voucher.data?.couponInfo?.code : null,
    );

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, BaseState<List<CartModel>>>(
          listener: (context, state) {
            _calculateCheckout();
          },
        ),
        BlocListener<ValidatePromoCubit, BaseState<PromoCardResponse>>(
          listener: (context, state) {
            _calculateCheckout();
          },
        ),
      ],
      child: BaseBlocConsumer<CheckoutSummeryCubit, CheckoutSummeryModel>(
        successBuilder: (sum) => OrderReceiptCard(summery: sum),
        loadingBuilder:  ()=>OrderReceiptCard(summery: CheckoutSummeryModel.fake()),
      ),
    );
  }
}
