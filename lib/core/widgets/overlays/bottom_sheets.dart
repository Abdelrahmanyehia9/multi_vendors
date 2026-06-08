import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';

class BottomSheets {
  const BottomSheets._();

  static Future<T?> show<T>(BuildContext context, {
    required Widget child,
    bool dismissible = true,
    bool enableDrag = false,
    bool showCloseButton = false,
    bool showPattern = false,
    Color? backgroundColor,
    double borderRadius = Decorations.borderRadius24,
    List<BoxShadow>? shadow,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: dismissible,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            InkWell(
              onTap: dismissible ? context.pop : null,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: const SizedBox.expand(),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .padding
                  .bottom),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: shadow,
                  color: backgroundColor ?? context.scaffoldBackground,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(borderRadius.r),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    child,
                    if (showCloseButton)
                      AppClick(
                        onTap: context.pop,
                        child: CircleAvatar(
                          radius: 20.r,
                          backgroundColor: AppColors.primary,
                          child: Icon(
                            MvIcons.close,
                            size: 22.sp,
                            color: Colors.white,
                          ),
                        ).appPaddingHr.paddingVr(8),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showWarning(BuildContext context,
      {String title = AppStrings.areYouSure,
        IconData icon = MvIcons.warning,
        Color iconColor = AppColors.primary,
        VoidCallback? onConfirm,
        String message = AppStrings
          .areYouSureToDoThisAction}) async{
    final result = await show(context,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.h,
          children: [
            Icon(icon, size: 80.sp, color: iconColor,),
            Gap.small(),
            Text(title.tr() , textAlign: TextAlign.center, style: TextStyles.bodyLarge,),
            Text(message.tr(), textAlign: TextAlign.center, style: TextStyles.captionMedium,),
            Gap.medium(),
            AppButton(text: AppStrings.confirm.tr(), buttonSize: null, onPressed: (){
              context.pop(true) ;
            },),
            AppButton.text(text: AppStrings.cancel.tr(), onPressed: (){
              context.pop(false) ;
            })
          ],

        ).paddingHr(8)
    );
    if(!context.mounted) return ;
    if(result == true){
      onConfirm?.call();
      return ;
    }
  }
}
