import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/widgets/app_cached_network_image.dart';
import 'circular_box.dart';

class UserAvatar extends StatelessWidget {
  final double size ;
  const UserAvatar({super.key, this.size = 60});

  @override
  Widget build(BuildContext context) {
  return CircularBox(
    radius: size.w,
    child: AppCachedNetworkImage(imageUrl,
    width: size.w,
    height: size.h,
    ),
  );
  }


  String get imageUrl => 'https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg';
}
