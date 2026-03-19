import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/text_styles.dart';
import 'gap.dart';
enum MessagesAlertType{
  orderSuccess ;
  String get title => "Order Successful";
  String get message => "We are happy to inform you that your purchase has been completed. Thank you for your trust in shopping at our store";
  IconData get icon => Icons.verified;
  Color get color => AppColors.success;
}




class MessageAlert extends StatelessWidget {
  final MessagesAlertType type ;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle ;
  final double iconSize ;
  const MessageAlert(this.type, {super.key,
    this.titleStyle,
    this.messageStyle,
    this.iconSize = 80
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(type.icon, color: type.color, size: iconSize.sp,),
        Text(type.title, textAlign: TextAlign.center, style: titleStyle?? TextStyles.labelMedium,),
        Gap.tiny(),
        Text(type.message, textAlign: TextAlign.center, style: messageStyle?? TextStyles.captionMedium,),
      ],
    );
  }
}
