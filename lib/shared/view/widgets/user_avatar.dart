import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'package:multi_vendor/shared/view/widgets/circular_box.dart';

class UserAvatar extends StatefulWidget {
  final double size;
  final String? profile;
  final String? userName ;

  const UserAvatar({
    super.key,
    this.profile,
    this.size = 60,
    this.userName,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  late final Color randomColor;

  @override
  void initState() {
    super.initState();

    randomColor = AppColors.mainDarkColors[
    Random().nextInt(AppColors.mainDarkColors.length)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final String? image = widget.profile;

    return CircularBox(
      backgroundColor: randomColor.veryLight,
      child: image == null || image.isEmpty
          ? _buildText()
          : AppCachedNetworkImage(
        image,
        width: widget.size.w,
        height: widget.size.w,
      ),
    );
  }

  Widget _buildText() {
    final String userName = widget.userName?? userCubit.userName  ;
    final String firstLetter = userName[0] ;
    return SizedBox(
      width: widget.size.w,
      height: widget.size.w,
      child: Center(
        child: Text(
          firstLetter.toUpperCase(),
          style: TextStyles.labelMedium.copyWith(
            fontSize: widget.size.sp / 2.2,
            color: randomColor,
          ),
        ),
      ),
    );
  }
}