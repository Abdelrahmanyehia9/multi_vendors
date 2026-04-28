import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:multi_vendor/features/shop/cart/logic/cart_cubit.dart';
import 'package:multi_vendor/features/shop/cart/logic/validate_promo_cubit.dart';
import 'package:multi_vendor/features/shop/checkout/logic/checkout_summery_cubit.dart';
import 'package:multi_vendor/features/shop/shared/mixin/checkout_summery_mixin.dart';
import 'package:multi_vendor/features/shop/shared/model/checkout_model.dart';
import 'package:multi_vendor/features/shop/shared/widgets/order_recipt_card.dart';

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
