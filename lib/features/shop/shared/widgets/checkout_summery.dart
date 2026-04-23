import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import '../../../../core/cubit/base_bloc_consumer.dart';
import '../../../../core/cubit/base_state.dart';
import '../../cart/data/models/cart_model.dart';
import '../../cart/data/models/promo_code_model.dart';
import '../../cart/logic/cart_cubit.dart';
import '../../cart/logic/validate_promo_cubit.dart';
import '../../checkout/logic/checkout_summery_cubit.dart';
import '../mixin/checkout_summery_mixin.dart';
import '../model/checkout_model.dart';
import 'order_recipt_card.dart';

class CheckoutSummery extends StatefulWidget {
  const CheckoutSummery({super.key});

  @override
  State<CheckoutSummery> createState() => _CheckoutSummeryState();
}

class _CheckoutSummeryState extends State<CheckoutSummery>  with CheckoutSummeryMixin{
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CartCubit, BaseState<List<CartModel>>>(
          listenWhen: (prev, curr)=> curr.isSuccess && !curr.data.isNullOrEmpty,
          listener: (context, state) {
            calculateCheckout();
          },
        ),
        BlocListener<ValidatePromoCubit, BaseState<PromoCardResponse>>(
          listenWhen: (prev, curr)=> curr.isSuccess && curr.data?.valid == true,
          listener: (context, state) {
            calculateCheckout();
          },
        ),
      ],
      child: BaseBlocConsumer<CheckoutSummeryCubit, CheckoutSummeryModel>(
        successBuilder: (sum) => OrderReceiptCard(summery: sum, coupon: context.read<ValidatePromoCubit>().state.data?.couponInfo),
        loadingBuilder:  ()=>OrderReceiptCard(summery: CheckoutSummeryModel.fake()),
      ),
    );
  }
}
