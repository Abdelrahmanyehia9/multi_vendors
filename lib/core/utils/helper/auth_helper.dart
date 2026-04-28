import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';

import 'package:multi_vendor/shared/view/widgets/message_alert.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';


final class AuthHelper{
  static Future<void> checkAuth(GestureTapCallback whenAuth,BuildContext context)async{
    if(!userCubit.isGuest){
      return whenAuth.call();
    }
 final result =  await BottomSheets.show<bool>(context, child: Column(
   mainAxisSize: MainAxisSize.min,
   spacing: 8.h,
      children: [
        const MessageAlert(MessagesAlertType.loginRequired),
        AppButton(
          text: "Login",
          buttonSize: null,
          onPressed: ()=>context.pop(true),
        ),
        AppButton.outlined(
          text: "Continue as Guest",
          onPressed: context.pop
        ),
      ],
    ).appPaddingAll);
    if(result==true&&context.mounted){
      context.pushNamed(Routes.loginScreen);
    }else{
      return ;
    }
  }



}