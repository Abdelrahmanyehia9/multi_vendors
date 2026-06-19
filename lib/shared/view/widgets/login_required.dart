import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/widgets/overlays/bottom_sheets.dart';
import 'package:multi_vendor/shared/view/widgets/message_alert.dart';

class LoginRequired extends StatelessWidget {
  final Widget child;
  final bool? guest ;
  const LoginRequired({super.key, this.guest, required this.child, });

  @override
  Widget build(BuildContext context) {
    bool isGuest = guest ?? userCubit.isGuest ;
    return isGuest ? _guestBuilder(context) : child;
  }

  Widget _guestBuilder(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const MessageAlert(MessagesAlertType.loginRequired),
      Gap.large(),
      AppButton(
        text: AppStrings.login.tr(),
        buttonSize: null,
        onPressed: () => context.pushNamed(Routes.loginScreen),
      ),
      Gap.small(),
      AppButton.outlined(
        text: AppStrings.continueAsGuest.tr(),
        onPressed: context.pop,
      ),
    ],
  ).appPaddingHr;

  static  Future<void> loginRequiredBottomSheets(GestureTapCallback whenAuth,BuildContext context)async{
    if(!userCubit.isGuest){
      return whenAuth.call();
    }

    final result =  await BottomSheets.show<bool>(context, child: Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.h,
      children: [
        const MessageAlert(MessagesAlertType.loginRequired),
        AppButton(
          text: AppStrings.login.tr(),
          buttonSize: null,
          onPressed: ()=>context.pop(true),
        ),
        AppButton.outlined(
            text: AppStrings.continueAsGuest.tr(),
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
