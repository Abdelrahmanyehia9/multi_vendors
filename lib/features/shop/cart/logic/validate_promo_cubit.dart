import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/shop/cart/data/models/cart_model.dart';
import 'package:multi_vendor/features/shop/cart/data/models/promo_code_model.dart';
import 'package:multi_vendor/features/shop/cart/data/repository/promo_code_repository.dart';

class ValidatePromoCubit extends Cubit<BaseState<PromoCardResponse>>{
  final PromoCodeRepository _repository ;
  ValidatePromoCubit(this._repository) : super(const BaseState.initial());

  Future<void>validatePromo({required List<CartModel> items,required String code})async{
    safeEmit(const BaseState.loading());
    final result = await _repository.validatePromo(cart: items, code: code);
    result.fold(
      (l) => safeEmit(BaseState.failure(l)),
      (r) => safeEmit(BaseState.success(r)),
    );
  }
  void reset(){
    safeEmit(const BaseState.initial());
  }

}