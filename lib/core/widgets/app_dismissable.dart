import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';

/// Visual config for one swipe direction's background (icon, label, color).
class AppDismissAction {
  final IconData icon;
  final String? label;
  final Color color;
  final Color foreground;

  const AppDismissAction({
    required this.icon,
    this.label,
    this.color = AppColors.error,
    this.foreground = Colors.white,
  });
}

class AppDismissable extends StatelessWidget {
  final Widget child;
  final void Function(DismissDirection direction) onDismissed;
  final DismissDirection direction;
  final AppDismissAction? startAction;
  final AppDismissAction? endAction;
  final Future<bool> Function(DismissDirection direction)? confirmDismiss;
  final double borderRadius;
  final Map<DismissDirection, double> dismissThresholds;

  const AppDismissable({
    required super.key,
    required this.child,
    required this.onDismissed,
    this.direction = DismissDirection.horizontal,
    this.startAction,
    this.endAction,
    this.confirmDismiss,
    this.borderRadius = 16,
    this.dismissThresholds = const {
      DismissDirection.startToEnd: 0.4,
      DismissDirection.endToStart: 0.4,
    },
  });

  // `isStart` is now passed explicitly per call instead of being inferred
  // from `this.direction` -- that was always resolving the same way for
  // both background and secondaryBackground, so both ended up with the
  // same (often wrong) alignment.
  Widget _background(AppDismissAction? action, {required bool isStart}) {
    if (action == null) return const SizedBox.shrink();
    return Container(
      decoration: BoxDecoration(
        color: action.color,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
        isStart ? MainAxisAlignment.start : MainAxisAlignment.end,
        spacing: 12.w,
        children: [
          Icon(action.icon, color: action.foreground),
          if (action.label != null)
            Text(
              action.label!,
              style: TextStyles.labelSmall.copyWith(color: action.foreground),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dismissDirection = startAction != null
        ? DismissDirection.startToEnd
        : DismissDirection.endToStart;

    // Save the *real* locale direction so the actual content (text/icons
    // inside `child`) still renders correctly per the app's language.
    final contentDirection = Directionality.of(context);

    return Directionality(
      // Lock swipe semantics to one fixed physical direction. Dismissible
      // resolves startToEnd/endToStart using Directionality.of(context),
      // so without this override the swipe-to-dismiss gesture flips
      // between Arabic (RTL) and English (LTR) locales.
      textDirection: TextDirection.ltr,
      child: Dismissible(
        key: key!,
        direction: (startAction != null && endAction != null)
            ? direction
            : dismissDirection,
        dismissThresholds: dismissThresholds,
        background: _background(startAction, isStart: true),
        secondaryBackground: _background(endAction, isStart: false),
        confirmDismiss: confirmDismiss,
        onDismissed: onDismissed,
        child: Directionality(
          textDirection: contentDirection,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius.r),
            child: child,
          ),
        ),
      ),
    );
  }
}