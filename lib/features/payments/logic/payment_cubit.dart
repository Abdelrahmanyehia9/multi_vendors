import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/cubit/base_state.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/features/payments/data/repository/payment_repository.dart';
import 'package:multi_vendor/features/payments/logic/strategy/payment_strategy.dart';

class PaymentCubit extends Cubit<BaseState<int?>> {
  final PaymentRepository _repository ;
   PaymentCubit(this._repository) : super(const BaseState.initial());


   Future<void>payment({required PaymentStrategy strategy, required double amount})async{
     safeEmit(const BaseState.loading()) ;
     final response  = await _repository.pay(strategy, amount: amount);
     response.fold(
       (l) => safeEmit(BaseState.failure(l)),
       (r) => safeEmit(BaseState.success(r))
     ) ;
   }
   Future<void>deletePayment({required int paymentId})async{
     safeEmit(const BaseState.loading()) ;
     final response = await _repository.deletePayment(paymentId);
     response.fold(
       (l) => safeEmit(BaseState.failure(l)),
       (r) => safeEmit(const BaseState.success(null))
     ) ;

   }
}