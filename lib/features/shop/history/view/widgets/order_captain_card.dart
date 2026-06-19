import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/service/url_launcher.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'package:multi_vendor/shared/view/widgets/user_avatar.dart';

class OrderCaptainCard extends StatelessWidget {
  final UserModel captain ;
  const OrderCaptainCard({super.key, required this.captain});

  @override
  Widget build(BuildContext context) {
    final low = context.colors.surfaceContainerLow;
    final highest = context.colors.surface;
    final lowest = context.colors.onSurface;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.orderHasAssigned.tr(),
          style: TextStyles.labelSmall
        ),
        Gap.small(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
            color: highest,
            boxShadow: Decorations.shadow,
          ),
          child: Row(
            spacing: 16.w,
            children: [
              UserAvatar(
                size: 40,
                userName: captain.fullName,
                profile: captain.profilePic,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(captain.fullName??"", style: TextStyles.bodyMedium.copyWith(color: lowest)),
                  Text(captain.phone??"", style: TextStyles.bodyMedium.copyWith(color: low)),
                ],
              ),
              const Spacer(),
              AppIconButton(
                onTap: ()async{
                  if(captain.phone == null) return ;
                  await UrlLauncherService.instance.launchPhoneCall(captain.phone!) ;
                },
                icon: MvIcons.call,
              backGroundColor: lowest,
                iconColor: highest,
              )
            ],
          ),
        )
      ],
    );
  }
}
