import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/utils/app_constants.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/features/authentication/logic/social_login_cubit.dart';

class AuthSocialLogin extends StatelessWidget {
  const AuthSocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SocialLoginCubit>();
    return BaseBlocConsumer<SocialLoginCubit,  Unit>(
      onFailure: (f) =>context.errorBar(message: f.message),
      builder:(s)=> Column(
        spacing: 12.h,
        children:  AppConstants.socialAuth.map(
          (e) => AppButton.outlined(
        text: e.text.tr(),
        color: context.colors.surfaceContainer,
        onPressed:()=> cubit.loginWithProvider(e),
        icon: SvgPicture.asset(e.iconPath, width: 30.w, ),
      ),
      ).toList(),
      ),
    );
  }
}
