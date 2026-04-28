import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/widgets/buttons/app_button.dart';
import 'package:multi_vendor/core/widgets/gap.dart';


class AppDialogues {
  const AppDialogues._();

  static Future<T?> showDialogue<T>(
    BuildContext context, {
    bool showCloseButton = true,
    final Color? patternColor,
    Color? backgroundColor,
    double borderRadius = 16,
    List<BoxShadow>? shadow,
    required Widget child,
    bool dismissable = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dismissable,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return Center(
          child: SizedBox(
            width: size.width * 0.7,
            child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: shadow,
                      color:
                          backgroundColor ??
                          Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: child,
                        ),
                        if (showCloseButton)
                          GestureDetector(
                            onTap: context.pop,
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.primary,
                              child: Icon(Icons.close, color: Colors.white),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  static Future<void> showWarning(
    BuildContext context, {
    IconData icon = Icons.warning_rounded,
    String title = "Are you sure ? ",
    String message = "Are you sure you want to do this action (you can't undo it) ? ",
    void Function()? onConfirm,
  }) async{
    final result = await showDialogue(context,
        showCloseButton: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 4.h,
          children: [
            Icon(icon, size: 64.sp, color: AppColors.primary,),
            Gap.small(),
            Text(title , textAlign: TextAlign.center, style: TextStyles.labelLarge,),
            Text(message, textAlign: TextAlign.center, style: TextStyles.captionMedium,),
            Gap.small(),
            AppButton(text: "submit", buttonSize: null, onPressed: (){
              context.pop(true) ;
            },),
            AppButton.outlined(text: "Cancel", onPressed: (){
              context.pop(false) ;
            })
          ],

        ) );
    if(!context.mounted) return ;
    if(result == true){
      onConfirm?.call();
      return ;
    }
  }

}
