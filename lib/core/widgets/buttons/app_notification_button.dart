import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/features/notifications/logic/notification_count_cubit.dart';

class AppNotificationButton extends StatelessWidget {
  const AppNotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCountCubit, int>(
      builder:(context, count)=> Badge(
        isLabelVisible: count > 0,
        textStyle: TextStyles.labelSmall.copyWith(
          fontWeight: FontWeightHelper.extraBold,
        ),
        label: Center(child: Text(count.compactNumber)),
        child: AppIconButton(
          tooltip: AppStrings.notifications.tr(),
          icon: MvIcons.notification,
          onTap: () => context.pushNamed(Routes.notifications),
        ),
      ),
    );
  }
}
