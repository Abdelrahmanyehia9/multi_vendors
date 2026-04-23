import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/features/payments/logic/strategy/payment_strategy.dart';

import '../../../features/payments/logic/strategy/cod_pay.dart';
import '../../../features/payments/logic/strategy/store_pay.dart';

final class PaymentHelper{
  const PaymentHelper._();
  static const PaymentHelper _instance = PaymentHelper._();
  static PaymentHelper get instance => _instance;


  PaymentStrategy fromOption(PaymentOption option){
    return switch(option){
      PaymentOption.store => StorePayment(),
      PaymentOption.cod => CodPayment(),
    };
  }


}