import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:multi_vendor/core/service/auth_service.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/service/storage_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/core/errors/exceptions.dart';
import 'package:multi_vendor/shared/data/models/address_model.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'dart:io';

class ProfileRepository {
  final AuthenticationService _service;
  final DatabaseService _db;
  final StorageService _storageService;

  const ProfileRepository(this._service, this._db, this._storageService);

  Future<Either<AppException, Unit>> changePassword(String password) async {
    try {
      await _service.updateUser(password: password);
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, Unit>> editUser(
    UserModel? user,
  ) async {
    try {
      await _db.UPDATE(
        id: user?.id,
        data: user?.toJson(),
        table: RemoteDatabaseConstants.profile_table,
      );
      await _updateMetaData();
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }

  Future<Either<AppException, String>> removeProfilePic() async {
    try {
      await _db.UPDATE(
        id: _service.currentUser?.id,
        data: {"profile_pic": null},
        table: RemoteDatabaseConstants.profile_table,
      );
      await _updateMetaData();
      return right("Profile Picture Removed Successfully");
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<Either<AppException, String>> addProfilePic(String path) async {
    try {
      final url = await _uploadProfilePic(path);
      await _db.UPDATE(
        id: _service.currentUser?.id,
        data: {"profile_pic": url},
        table: RemoteDatabaseConstants.profile_table,
      );
      await _updateMetaData();
      return right("Profile Picture Added Successfully");
    } catch (e) {
      return left(e.toAppException);
    }
  }
  Future<String> _uploadProfilePic(String path)async{
    final url = await _storageService.uploadAndGetUrl(File(path),
        bucketName: "Users",
        folderName: _service.currentUser?.id ?? "unknown",) ;
    return url;
  }
  Future<void>_updateMetaData() async {
    await _service.updateUser(data: {"updated_at": DateTime.now().toIso8601String()});
  }
  Future<Either<AppException, Unit>> editAddress(AddressModel address) async {
    try {
      await _db.UPSERT(
        data: address.toJson(),
        table: RemoteDatabaseConstants.address_table,
      );
    await _updateMetaData();
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
