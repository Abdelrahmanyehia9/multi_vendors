import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/shared/view/widgets/cards/cart_card.dart';

class CartList extends StatelessWidget {
  final List<CartModel> cart;

  const CartList({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: cart.length,
      primary: false,
      padding: EdgeInsets.zero,
      separatorBuilder: (_, i) => Divider(height: 24.h).appPaddingHr,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) => CartCard(cartItem: cart[i]),
    );
  }
}
