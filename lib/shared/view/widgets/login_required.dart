import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
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
        onPressed: () =>
            context.pushNamedAndRemoveUntil(Routes.mainLayout,predicate: (_)=>false ,arguments: 0),
      ),
    ],
  ).appPaddingHr;
}
