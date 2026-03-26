// import 'dart:ui';
// import 'package:elmazraa/core/extensions/navigation.dart';
// import 'package:elmazraa/core/extensions/theme.dart';
// import 'package:elmazraa/core/extensions/widgets.dart';
// import 'package:flutter/material.dart';
// import '../../theme/app_colors.dart';
// import '../../theme/text_styles.dart';
// import '../../utils/assets.dart';
// import '../spacing.dart';
//
// class Dialogues {
//   const Dialogues._();
//
//   static Future<T?> showDialogue<T>(
//     BuildContext context, {
//     bool showPattern = false,
//     bool showCloseButton = true,
//     final Color? patternColor,
//     Color? backgroundColor,
//     double borderRadius = 16,
//     List<BoxShadow>? shadow,
//     required Widget child,
//     bool dismissable = true,
//   }) {
//     return showDialog<T>(
//       context: context,
//       barrierDismissible: dismissable,
//       builder: (context) {
//         final size = MediaQuery.of(context).size;
//         return Center(
//           child: SizedBox(
//             width: size.width * 0.7,
//             child: Material(
//               color: Colors.transparent,
//               child: Stack(
//                 children: [
//                   Positioned.fill(
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//                       child: Container(color: Colors.transparent),
//                     ),
//                   ),
//                   DecoratedBox(
//                     decoration: BoxDecoration(
//                       image: showPattern
//                           ? DecorationImage(
//                               alignment: Alignment.topCenter,
//                               opacity: 0.1,
//                               colorFilter: ColorFilter.mode(
//                                 patternColor ?? AppColors.primary,
//                                 BlendMode.srcIn,
//                               ),
//                               image: const AssetImage(Assets.animalPattern),
//                               fit: BoxFit.cover,
//                             )
//                           : null,
//                       boxShadow: shadow,
//                       color:
//                           backgroundColor ??
//                           Theme.of(context).scaffoldBackgroundColor,
//                       borderRadius: BorderRadius.circular(borderRadius),
//                     ),
//                     child: Stack(
//                       alignment: AlignmentDirectional.topEnd,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(16),
//                           child: child,
//                         ),
//                         if (showCloseButton)
//                           GestureDetector(
//                             onTap: context.pop,
//                             child: const CircleAvatar(
//                               radius: 20,
//                               backgroundColor: AppColors.primary,
//                               child: Icon(Icons.close, color: Colors.white),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   static Future<T?> showBasicDialogue<T>({
//     required BuildContext context,
//     Widget? icon,
//     String? title,
//     bool showCloseButton = true,
//     String? description,
//     TextStyle? titleStyle,
//     TextStyle? descriptionStyle,
//     Widget? action,
//     Widget? action2,
//     bool dismissable = true,
//   }) {
//     return showDialogue<T>(
//       context,
//       showCloseButton: showCloseButton,
//       dismissable: dismissable,
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             if (icon != null) ...[icon, const Gap(16)],
//             if (title != null) ...[
//               Text(
//                 title,
//                 style: titleStyle ?? TextStyles.headline3,
//                 textAlign: TextAlign.center,
//               ),
//             ],
//             if (description != null) ...[
//               Text(
//                 description,
//                 style:
//                     descriptionStyle ??
//                     TextStyles.bodyLarge.copyWith(
//                       color: context.colorScheme.surfaceContainerHigh,
//                     ),
//                 textAlign: TextAlign.center,
//               ),
//               const Gap(16),
//             ],
//             if (action != null) ...[action, const Gap(8)],
//             if (action2 != null) ...[action2, const Gap(4)],
//           ],
//         ).appPaddingHr(),
//       ),
//     );
//   }
// }
