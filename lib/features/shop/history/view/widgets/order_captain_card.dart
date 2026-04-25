import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/core/widgets/circular_box.dart';

import '../../../../../core/models/user_model.dart';
import '../../../../../core/theme/decorations.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../../core/widgets/buttons/app_icon_button.dart';
import '../../../../../core/widgets/section_header.dart';

class OrderCaptainCard extends StatelessWidget {
  final UserModel captain ;
  const OrderCaptainCard({super.key, required this.captain});

  @override
  Widget build(BuildContext context) {
    final low = context.colors.surfaceContainerLow;
    final highest = context.colors.surfaceContainerHighest;
    final lowest = context.colors.surfaceContainerLowest;
    return Column(
      children: [
        const SectionHeader(title: "Order has been Assigned"),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Decorations.borderRadius16.r),
            color: highest,
          ),
          child: Row(
            spacing: 16.w,
            children: [
              CircularBox(
                child: AppCachedNetworkImage(captain.profilePic),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(captain.fullName??"", style: TextStyles.bodyMedium.copyWith(color: lowest)),
                  Text(captain.phone??"", style: TextStyles.bodyMedium.copyWith(color: low)),
                ],
              ),
              const Spacer(),
              AppIconButton(icon: Icons.call,
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
