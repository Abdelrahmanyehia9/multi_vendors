import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/service/notification/notification_service.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/features/main/profile/view/widgets/profile_list_tile.dart';

class NotificationSwitcher extends StatefulWidget {
  const NotificationSwitcher({super.key});

  @override
  State<NotificationSwitcher> createState() => _NotificationSwitcherState();
}

class _NotificationSwitcherState extends State<NotificationSwitcher> {
    final ValueNotifier<bool> _isNotificationEnabled = ValueNotifier<bool>(NotificationService.instance.oneSignal.isSubscribed);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isNotificationEnabled,
      builder: (context, value, child) {
        return ProfileListTile(
          icon: MvIcons.notification,
          title: AppStrings.notifications.tr(),
          trailing: Switch(
            value: value,
            onChanged: (_) {
              _isNotificationEnabled.value = !value;
              if(value){
               return NotificationService.instance.oneSignal.optOut();
              }
              NotificationService.instance.oneSignal.optIn();
            },
            thumbColor: const WidgetStatePropertyAll(AppColors.primary),
            activeTrackColor: context.colors.surfaceContainerLowest,
            inactiveTrackColor: context.colors.surfaceContainerLowest,
            thumbIcon: thumbIcon(),
          ),
        );
      }
    );
  }

  WidgetStateProperty<Icon?>thumbIcon()=>WidgetStateProperty.resolveWith<Icon>((states) {
    if (states.contains(WidgetState.selected)) {
      return const Icon(MvIcons.notification, color: AppColors.white,);
    }
    return const Icon(MvIcons.notificationOff , color: AppColors.white,);
  });


  @override
  void dispose() {
    _isNotificationEnabled.dispose();
    super.dispose();
  }
}
