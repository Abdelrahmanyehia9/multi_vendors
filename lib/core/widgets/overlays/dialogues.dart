import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import '../../theme/app_colors.dart';


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
}
