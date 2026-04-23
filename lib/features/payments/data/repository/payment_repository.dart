import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/features/payments/logic/strategy/payment_strategy.dart';

import '../../../../core/service/database_service.dart';
import '../../../../core/utils/remote_database_constants.dart';

class PaymentRepository{
  final DatabaseService _db ;
 const PaymentRepository(this._db);



  Future<Either<AppException, int>> pay(PaymentStrategy strategy, {required double amount})async{
   try{
     final paymentResponse = strategy.pay(amount);
     final response = await _db.INSERT(table: RemoteDatabaseConstants.payment_table,
         data: paymentResponse.toJson()
     );
     return right(response[RemoteDatabaseConstants.id_column]);
   }catch(e){
     return left(e.toAppException) ;
   }
  }
  Future<Either<AppException, Unit>> deletePayment(int paymentId)async{
   try{
     await _db.DELETE(
       table: RemoteDatabaseConstants.payment_table,
       id: paymentId
     );
     return right(unit);
   }catch(e){
     return left(e.toAppException) ;
   }
  }






}