import 'package:flutter/cupertino.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';

class SplashLogic{
  const SplashLogic._();


  static Future<void>init(BuildContext context)async{
   await Future.delayed(const Duration(seconds: 3)) ;
   if(context.mounted){
     context.pushNamed(Routes.onBoarding) ;
   }
  }


}