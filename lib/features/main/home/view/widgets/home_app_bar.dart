import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/gap.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/user_avatar.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         AppClick(
           onTap: ()=>context.pushNamedAndRemoveUntil(Routes.mainLayout, predicate: (_)=>false, arguments: 4),
           child: const UserAvatar(
             size: 48,
           ),
         ),
        Gap.small(),
        _nameWithLocation(),
        Gap.small(),
        /// Notifications
        const AppIconButton(icon: Icons.shopping_bag),
        Gap.small(),
        /// Cart
        const Badge(
          label: Text('1'),
          child: AppIconButton(icon: Icons.notifications),
        ),
      ],
    );
  }

  Widget _nameWithLocation(){
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            "ahmed khaled",
            maxLines: 1,
            style: TextStyles.labelSmall,
            overflow: TextOverflow.ellipsis,
          ),
          Row(
            children: [
              Icon(Icons.location_pin, size: 14.sp),
               Expanded(
                child: Text(
                  "6 october city , Egypt" ,
                  style: TextStyles.captionMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    ) ;
  }
}