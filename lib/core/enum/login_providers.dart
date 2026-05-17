import 'dart:ui';

import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthFormType {
  emailAndPassword,
  mobile ;


  static AuthFormType fromDatabase(String data){
    if(data == "email_password") return AuthFormType.emailAndPassword;
    return AuthFormType.mobile;
  }
}
enum SocialMediaAuth {
  facebook,
  google,
  apple;



  String get iconPath=>switch(this){
    SocialMediaAuth.facebook=>AppAssets.facebookIcon,
    SocialMediaAuth.google=>AppAssets.googleIcon,
    SocialMediaAuth.apple=>AppAssets.appleIcon,
  };
  String get text=>switch(this){
    SocialMediaAuth.facebook=>AppStrings.facebook,
    SocialMediaAuth.google=>AppStrings.google,
    SocialMediaAuth.apple=>AppStrings.apple,
  };
  Color get color=>switch(this){
   facebook=>const Color(0xff0866FF),
   google=>const Color(0xff4285F4),
   apple=> const Color(0xff000000),
  };
  OAuthProvider get provider=>switch(this){
   facebook=> OAuthProvider.facebook,
   google=> OAuthProvider.google,
   apple=> OAuthProvider.apple,
  };


}