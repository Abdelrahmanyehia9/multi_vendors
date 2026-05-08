import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';

class ProfileListTile extends StatelessWidget {
  final String title ;
  final IconData icon  ;
  final void Function(BuildContext)? onTap ;
  final Widget? trailing ;
  const ProfileListTile({super.key, this.onTap , this.trailing, required this.icon , required this.title});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: ()=>onTap?.call(context),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child:  Icon(icon, color: AppColors.white, size: 20.sp,)),
      title:  Text(title, style: TextStyles.bodyMedium,),
      trailing: trailing ?? Icon(MvIcons.arrowForwardIos, size: 18.sp, color: AppColors.grey,),
    );
  }
}
