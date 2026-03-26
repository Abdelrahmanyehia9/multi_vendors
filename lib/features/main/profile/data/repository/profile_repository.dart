import 'package:dartz/dartz.dart';
import 'package:multi_vendor/core/extensions/app_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/models/base_user_model.dart';

class ProfileRepository {
  final SupabaseClient _client;

  const ProfileRepository(this._client);

  Future<Either<AppException, Unit>> editProfile({BaseUserModel? user, String? email , String? password}) async {
    try {
      await _client.auth.updateUser(UserAttributes(email: email,password: password,
          data: user?.toJson()));
      return right(unit);
    } catch (e) {
      return left(e.toAppException);
    }
  }
}
