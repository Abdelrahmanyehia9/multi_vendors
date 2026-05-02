import 'package:flutter/foundation.dart' show debugPrint;
import 'package:multi_vendor/features/payments/logic/strategy/payment_strategy.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/features/payments/data/model/payment_response.dart';

class StorePayment implements PaymentStrategy{
  @override
  PaymentResponse pay(double amount) {
    debugPrint("Pay $amount using Store Payment") ;
    return PaymentResponse(option: PaymentOption.store, amount: amount);
  }
}