import 'package:collection/collection.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

enum PaymentStatus {
  pending, success, failed;
  static Map<PaymentStatus, String>  _map = {
    pending: 'pending',
    success: 'success',
    failed: 'failed',
  };
  String get toDatabase => _map[this]??"pending";
  factory PaymentStatus.fromDatabase(String status) {
    return _map.entries.firstWhereOrNull((e) => e.value == status)?.key??pending;
  }

  String get title => switch(this){
    success => "Paid" ,
    _ => "Pending",
  } ;

}

class PaymentResponse {
  final PaymentOption option;
  final String? transactionId;
  final DateTime? createdAt;
  final double amount;
  final PaymentStatus status;
  const PaymentResponse({
    required this.option,
    this.transactionId,
    required this.amount,
    this.createdAt,
    this.status = PaymentStatus.pending,
  });
  Map<String, dynamic>toJson()=>{
    "option": option.toDatabase,
    "transaction_id": transactionId,
    "amount": amount,
    "status": status.toDatabase,
  };
  factory  PaymentResponse.fromJson(Map<String, dynamic>json)=>PaymentResponse(
      option: PaymentOption.fromDatabase(json['option']),
      amount: json['amount'].toDouble(),
      transactionId: json['transaction_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      status: PaymentStatus.fromDatabase(json['status'])) ;
  factory  PaymentResponse.fake()=>PaymentResponse(
      option: PaymentOption.cod,
      amount: FakeData.fakeDouble,
      transactionId: FakeData.fakeStringTitle,
      createdAt: FakeData.fakeDateTime,) ;

}
