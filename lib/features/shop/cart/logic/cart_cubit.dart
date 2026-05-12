import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/data/repository/cart_repository.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';

class CartCubit extends Cubit<BaseState<List<CartModel>>> {
  final CartRepository _repository;
   List<CartModel> _cart = [];

  CartCubit(this._repository) : super(const BaseState.initial());

  Future<void> init() async {
    safeEmit(const BaseState.loading());
    final cart = await _repository.getCart();
    if (cart.isEmpty) return safeEmit(const BaseState.empty());
    _cart = cart;
    safeEmit(BaseState.success(List.from(_cart)));
  }

  Future<void> get _update async {
    if(_cart.isEmpty) {
      safeEmit(const BaseState.empty());
    } else {
      safeEmit(BaseState.success(List.from(_cart)));
    }
   await  _repository.updateCart(_cart);
  }

  int inCart(ProductModel item) {
    return _cart
        .firstWhereOrNull(
          (e) => e.product.uniqueId == item.uniqueId,
    )
        ?.quantity ??
        0;
  }

  void addToCart(ProductModel item) {
    final index =
    _cart.indexWhere((e) => e.product.uniqueId == item.uniqueId);

    if (index == -1) {
      _cart.add(CartModel(product: item, quantity: 1));
    } else {
      _cart[index] = _cart[index].copyWith(
        quantity: _cart[index].quantity + 1,
      );
    }
    _update;
  }

  void updateQuantity(bool increased, {required ProductModel item}) {
    final index =
    _cart.indexWhere((e) => e.product.uniqueId == item.uniqueId);
    if (index == -1) {
      if (increased) {
        _cart.add(CartModel(product: item, quantity: 1));
      }
      _update;
      return;
    }
    final current = _cart[index].quantity;
    final newQty = increased ? current + 1 : current - 1;
    if (newQty <= 0) {
      _cart.removeAt(index);
    }
    else {
      _cart[index] = _cart[index].copyWith(quantity: newQty);
    }
    _update;
  }

  void removeItem(ProductModel item) {
    _cart.removeWhere((e) => e.product.uniqueId == item.uniqueId);
    _update;
  }


  List<CartModel>get cartItems => _cart;
  void clearCart() {
    _cart.clear();
    _update;
  }

}