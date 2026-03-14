import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/app_button.dart';

class SectionHeader extends StatelessWidget {
  final String title ;
  final String? action ;
  final double verticalSpace ;
  final bool hasAction ;
  final GestureTapCallback? onActionTap ;
  const SectionHeader({super.key,this.onActionTap ,this.hasAction =true,this.verticalSpace =8 ,required this.title , this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: TextStyles.bodyMedium,),
        const Spacer(),
        if (hasAction)
        AppButton.text(text: action??"View all",style: TextStyles.bodySmall,
          onPressed:  onActionTap,

        )
      ],
    ).paddingVr(verticalSpace);
  }
}
