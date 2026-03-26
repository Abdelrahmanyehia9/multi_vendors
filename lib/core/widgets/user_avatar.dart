import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_states.dart';
import 'circular_box.dart';
import 'dart:math';

class UserAvatar extends StatefulWidget {
  final double size;
  const UserAvatar({super.key, this.size = 60});

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}
class _UserAvatarState extends State<UserAvatar> {
  late final Color randomColor;
  @override
  void initState() {
    super.initState();
    randomColor = AppColors.mainDarkColors[Random().nextInt(AppColors.mainColors.length)];
  }

  final String? img = userCubit.user?.profilePic;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserStates>(
      buildWhen: (p, c)=>c is UserUpdated,
      builder:(_,_)=>CircularBox(
        backgroundColor: randomColor.veryLight,
        child: img == null ? _buildText():
        AppCachedNetworkImage(
          thumbnail,
          width: widget.size.w,
          height: widget.size.w,
        ),
      ),
    );
  }


  Widget _buildText()=> SizedBox(
    width: widget.size.w, height: widget.size.w,
    child: Center(child: Text(userCubit.userName.substring(0,1), style: TextStyles.labelMedium.copyWith(
      fontSize: widget.size.sp / 2.2,
      color: randomColor,
    ),)),

  );
  String get thumbnail => userCubit.user?.profilePic ?? userCubit.userName;
}