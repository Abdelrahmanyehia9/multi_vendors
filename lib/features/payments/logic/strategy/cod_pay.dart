import 'package:flutter/foundation.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/features/payments/data/model/payment_response.dart';
import 'package:multi_vendor/features/payments/logic/strategy/payment_strategy.dart';

class CodPayment implements PaymentStrategy{
  @override
  PaymentResponse pay(double amount) {
    debugPrint("Pay $amount using COD") ;
    return PaymentResponse(option: PaymentOption.cod, amount: amount);
  }
}