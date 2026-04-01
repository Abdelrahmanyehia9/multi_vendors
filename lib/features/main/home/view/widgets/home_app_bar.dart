import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/cubit/user_cubit.dart';
import 'package:multi_vendor/core/cubit/user_states.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import '../../../../../core/DI/setup_get_it.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/user_avatar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      builder: (_, _) => Row(
        children: [
          Expanded(
            child: AppClick(
              onTap: () => context.pushNamedAndRemoveUntil(
                  Routes.mainLayout, predicate: (_) => false, arguments: 4),
              child: Row(
                children: [
                  const UserAvatar(size: 48),
                  Gap.small(),
                  Expanded(child: _nameWithLocation()),
                ],
              ),
            ),
          ),
          Gap.small(),
          Badge(
            label: Text('1', style: TextStyles.labelSmall),
            child:  AppIconButton(icon: Icons.shopping_cart, onTap: () => context.pushNamed(Routes.cart)),
          ),
        ],
      ),
    );
  }

  Widget _nameWithLocation() {
    final address = userCubit.user?.address;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          userCubit.userName,
          maxLines: 1,
          style: TextStyles.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          spacing: 4.w,
          children: [
            Icon(Icons.my_location, color: AppColors.primary, size: 14.sp),
            Expanded(
              child: Text(
                address ?? "Not defined",
                style: TextStyles.captionMedium.copyWith(color: AppColors.primary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}