import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/decorations.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';

class BottomSheets {
  const BottomSheets._();
  static Future<T?> show<T>(
    BuildContext context, {
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
              padding:  EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
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

}
//
// static Future<T?> showBasic<T>({
//   required BuildContext context,
//   Widget? icon,
//   String? title,
//   String? subtitle,
//   Widget? action,
//   Widget? action2,
//   bool dismissible = true,
//   bool showCloseButton = true,
//   bool showPattern = false,
// })
// {
//   return show<T>(
//     context,
//     dismissible: dismissible,
//     showCloseButton: showCloseButton,
//     showPattern: showPattern,
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         if (icon != null) ...[icon, const Gap(8)],
//         if (title != null)
//           Text(
//             title,
//             style: TextStyles.labelMedium,
//             textAlign: TextAlign.center,
//           ),
//         if (subtitle != null)
//           Text(
//             subtitle,
//             style: TextStyles.bodyMedium.copyWith(
//               color: context.colorScheme.surfaceContainerHigh,
//               fontWeight: FontWeightHelper.regular,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         const Gap(16),
//         if (action != null) ...[action, const Gap(8)],
//         if (action2 != null) ...[action2, const Gap(4)],
//       ],
//     ).appPaddingHr(),
//   );
// }
//
// static Future<bool> alertBottomSheet({
//   required BuildContext context,
//   String? title,
//   required String message,
// })
// async {
//   final bool? selected = await BottomSheets.showBasic<bool>(
//     context: context,
//     title: title ?? "هل انت متاكد",
//     showCloseButton: false,
//     icon: Column(
//       children: [
//         const Gap(24),
//         Icon(AppIcons.warning, size: 60.sp, color: AppColors.warning),
//       ],
//     ),
//     subtitle: message,
//     action: AppButton(
//       text: "تاكيد",
//       onPressed: () => context.pop(true),
//       height: 40,
//     ),
//     action2: AppButton(
//       text: "الغاء",
//       onPressed: () => context.pop(false),
//       height: 40,
//       isTextButton: true,
//     ),
//   );
//   return selected ?? false;
// }