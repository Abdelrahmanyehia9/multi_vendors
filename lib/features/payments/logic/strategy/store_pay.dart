import 'package:multi_vendor/features/payments/logic/strategy/payment_strategy.dart';

import '../../../../core/enum/payment_option.dart';
import '../../data/model/payment_response.dart';

class StorePayment implements PaymentStrategy{
  @override
  PaymentResponse pay(double amount) {
    print("Pay $amount using Store Payment") ;
    return PaymentResponse(option: PaymentOption.store, amount: amount);
  }
}