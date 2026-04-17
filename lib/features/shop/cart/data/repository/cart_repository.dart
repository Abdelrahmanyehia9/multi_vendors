import 'package:multi_vendor/core/database/local_storage_constants.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';

import '../../../../../core/database/local_storage.dart';

class CartRepository {
  final LocalStorage _localStorage;
  CartRepository(this._localStorage);

  Future<List<CartModel>> getCart() async {
     final response = await _localStorage.read(LocalStorageConstants.cart);
    if (response is! List || response.isEmpty) return [];
    return response
        .map((e)=>CartModel.fromJson((e as Map).deepCast))
        .toList();
  }
  Future<void> updateCart(List<CartModel> cart) async {
    await _localStorage.write(
      LocalStorageConstants.cart,
      cart.map((e) => e.toJson()).toList(),
    );
  }


}