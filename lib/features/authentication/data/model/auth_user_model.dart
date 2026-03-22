import 'package:multi_vendor/core/models/base_user_model.dart';

class AuthUserModel extends BaseUserModel {
  const AuthUserModel({required super.email, super.fullName, super.phone});


  @override
  Map<String, dynamic> toJson(){
    return {
      'full_name': fullName,
      'profile_pic': profilePic,
      'fcm_token': fcmToken,
      'email': email,
      'phone': phone,
    };
  }
}
