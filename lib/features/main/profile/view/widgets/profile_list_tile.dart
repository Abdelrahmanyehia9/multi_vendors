import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

class ProfileListTile extends StatelessWidget {
  final String title ;
  final IconData icon  ;
  final void Function(BuildContext)? onTap ;
  const ProfileListTile({super.key, this.onTap , required this.icon , required this.title});

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      onTap: ()=>onTap?.call(context),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child:  Icon(icon, color: AppColors.white, size: 20.sp,)),
      title:  Text(title, style: TextStyles.bodyMedium,),
      trailing:  Icon(Icons.arrow_forward_ios, size: 18.sp, color: AppColors.grey,),
    );
  }
}
