import 'package:multi_vendor/features/payments/data/model/payment_response.dart';

abstract class PaymentStrategy{
  PaymentResponse pay(double amount) ;
}