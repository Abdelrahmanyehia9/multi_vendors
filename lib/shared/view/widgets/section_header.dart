import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';

class SectionHeader extends StatelessWidget {
  final String title ;
  final String? action ;
  final double verticalSpace ;
  final bool hasAction ;
  final GestureTapCallback? onActionTap ;
  final Widget? customAction ;
  final TextStyle ? headerStyle ;
  final MainAxisSize axisSize ;
  final TextStyle? actionStyle;
  const SectionHeader({super.key,this.actionStyle, this.axisSize = MainAxisSize.max,this.headerStyle, this.onActionTap, this.customAction ,this.hasAction =false,this.verticalSpace =8 ,required this.title , this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: axisSize,
      children: [
        Text(title, style:headerStyle?? TextStyles.bodyMedium,),
        if (hasAction)
...[
  const Spacer(),
  _buildAction(),
]

      ],
    ).paddingVr(verticalSpace);
  }

  Widget _buildAction(){
    late final Widget widget ;
    if(customAction!=null) {
      widget = customAction!;
    }else{
      widget =AppButton.text(text: action??"View all",style:actionStyle?? TextStyles.bodySmall,
          onPressed:  onActionTap);
    }
    return widget;
  }

}

