import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/models/address_model.dart';
import 'package:multi_vendor/core/models/user_model.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import '../../../../../core/errors/exceptions.dart';

class ProfileRepository {
  final AuthenticationService _service;
  final DatabaseService _db ; 
  const ProfileRepository(this._service, this._db);


  Future<Either<AppException , Unit>>changePassword(String password)async{
    try{

      await _service.updateUser(password: password);
      return right(unit);

    }catch(e){return left(e.toAppException); }
  }
  Future<Either<AppException , Unit>>changeEmail(String email)async{
    try{

      await _service.updateUser(email: email);
      return right(unit);

    }catch(e){return left(e.toAppException); }
  }
  Future<Either<AppException , Unit>>editUser(UserModel? user)async{
    try{
      await _service.updateUser(data: user?.toJson());
      return right(unit);

    }catch(e){return left(e.toAppException); }
  }
  Future<Either<AppException , Unit>>editAddress(AddressModel address)async{
    try{
     await _db.UPSERT(
        data:  address.toJson(),
          table: RemoteDatabaseConstants.address_table,
         ) ;
     _service.updateUser();
      return right(unit);

    }catch(e){return left(e.toAppException); }
  }
}
