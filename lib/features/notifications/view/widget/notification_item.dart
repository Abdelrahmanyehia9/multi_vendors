part of '../notification_screen.dart';

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;

  final bool isSelected;

  const _NotificationItem(this.notification, {this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final Color surfaceColor = isSelected
        ? context.colors.onSurface
        : context.colors.surface;
    final Color onSurfaceColor = isSelected
        ? context.colors.surface
        : context.colors.onSurface;
    return AppDeleteDismissable(
      key: ValueKey("notification_${notification.id}"),
      onDelete: () {
        context.read<NotificationCubit>().deleteNotifications([
          notification.id,
        ]);
        context.read<NotificationDeleteCubit>().deleteNotifications([
          notification.id,
        ]);
      },
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 2.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: surfaceColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              spacing: 4.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 12.w,
                  children: [
                    _buildThumb(radius:48),
                     Expanded(
                      child: Column(
                        spacing: 2.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notification.title.localized.removeEmojis(),
                            style: TextStyles.labelSmall.copyWith(
                              color: onSurfaceColor,
                            ),
                          ),
                          Text(
                            notification.message.localized.removeEmojis(),
                            style: TextStyles.bodySmall.copyWith(
                              color: onSurfaceColor,
                            ),
                          ),
                          if (notification.createdAt != null)
                            Text(
                              notification.createdAt!.timeAgo,
                              style: TextStyles.captionSmall.copyWith(
                                color: onSurfaceColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
          if (isSelected)
            Icon(
              MvIcons.checkedCircle,
              color: context.colors.primary,
              size: 16.sp,
            ).paddingAll(8),
        ],
      ),
    );
  }

  Widget _buildThumb({double radius = 40}) {
    if (notification.image != null) {
      return AppCachedNetworkImage(
        notification.image!,
        width: radius.w,
        height:( radius*1.1).w,
        radius: Decorations.borderRadius12.r,
      );
    }
    if (notification.template != null) {
      return AppIconButton(
        icon: notification.template!.icon,
        onTap: () {},
        size: (radius*.6),
        backGroundColor: notification.template!.color.veryLight,
        iconColor: notification.template!.color,
      );
    }
    return const SizedBox.shrink();
  }
}
