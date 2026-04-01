import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/models/base_user_model.dart';

class ProfileRepository {
  final AuthenticationService _service;

  const ProfileRepository(this._service);


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
  Future<Either<AppException , Unit>>editUser(BaseUserModel user)async{
    try{

      await _service.updateUser(data: user.toJson());
      return right(unit);

    }catch(e){return left(e.toAppException); }
  }
}
