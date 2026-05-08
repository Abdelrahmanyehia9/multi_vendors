import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_cart_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';
import 'package:multi_vendor/features/main/main_layout_cubit.dart';
import 'package:multi_vendor/shared/view/widgets/user_builder.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final layoutCubit = context.read<MainLayoutCubit>();
    return UserBuilder(
      builder: (u)=> Row(
        children: [
          Expanded(
            child: AppClick(
              onTap: ()=>layoutCubit.changePage(4),
              child: Row(
                children: [
                   UserAvatar(
                     size: 48,
                     profile: u?.profilePic,),
                  Gap.small(),
                  Expanded(child: _nameWithLocation(context)),
                ],
              ),
            ),
          ),
          Gap.small(),
          const AppCartButton(),
        ],
      ),
    ).appPaddingVr;
  }

  Widget _nameWithLocation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.welcomeBack.tr(), style: TextStyles.labelSmall.copyWith(
          color: context.colors.surfaceContainerLow,
          fontSize: 10.sp
        ),),
        Text(
          userCubit.userName.toUpperCase(),
          maxLines: 1,
          style: TextStyles.labelSmall.copyWith(
            fontWeight: FontWeightHelper.medium
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}