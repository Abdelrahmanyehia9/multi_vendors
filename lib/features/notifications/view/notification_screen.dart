library;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:multi_vendor/core/cubit/base_bloc_consumer.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/context.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/extensions/date_time.dart';
import 'package:multi_vendor/core/extensions/widget.dart';
import 'package:multi_vendor/core/theme/text_styles.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/mv_icons.dart';
import 'package:multi_vendor/core/widgets/app_click.dart';
import 'package:multi_vendor/core/widgets/app_states.dart';
import 'package:multi_vendor/core/widgets/buttons/app_delete_button.dart';
import 'package:multi_vendor/core/widgets/buttons/app_icon_button.dart';
import 'package:multi_vendor/core/widgets/overlays/popups.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_appbar.dart';
import 'package:multi_vendor/core/widgets/scaffold/base_scaffold.dart';
import 'package:multi_vendor/core/widgets/selection_builder.dart';
import 'package:multi_vendor/features/notifications/data/model/notification_model.dart';
import 'package:multi_vendor/features/notifications/logic/helper/notification_redirect_helper.dart';
import 'package:multi_vendor/features/notifications/logic/notification_delete_cubit.dart';
import 'package:multi_vendor/features/notifications/logic/notifications_cubit.dart';
import 'package:multi_vendor/shared/view/widgets/app_delete_dismissable.dart';
import 'package:multi_vendor/shared/view/widgets/selection_mode_header.dart';

part 'widget/notification_item.dart';
part 'widget/notification_list.dart';
part 'widget/notification_screen_actions.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notificationsCubit = context.read<NotificationCubit>();
    return SelectionBuilder<int>(
      builder: (state, cubit) {
        final data = notificationsCubit.state.data ;
        bool isAllSelected = data != null &&
            state.isAllSelected(
              data.map((e) => e.id).toList(),
            );
        return BaseScaffold(
          appBar: BaseAppBar(
            title: tr(AppStrings.notifications),
            actions: [
              _NotificationScreenAction(
                selectedNotifications: state.selected.toList(),
              )
            ],
          ),
          body: BaseBlocConsumer(
            bloc: context.read<NotificationDeleteCubit>(),
            onLoading: context.loaderOverlay.show,
            onSuccess: (_) {
              notificationsCubit.getAllNotifications();
              cubit.clear();
              context.loaderOverlay.hide();
            },
            onFailure: (e) {
              context.loaderOverlay.hide();
              context.errorBar(message: e.message);
            },
            builder: (_) => RefreshIndicator(
              onRefresh: () async => notificationsCubit.getAllNotifications(),
              child: Column(
                children: [
                  SelectionModeHeader(
                    isSelectionMode: state.isSelectionMode,
                    count: state.selected.length,
                    isAllSelected: isAllSelected,
                    onSelectAll: () => cubit.selectAll(data?.map((e) => e.id).toList()??[]),
                    onUnselectAll: cubit.unselectAll,
                  ),
                  Expanded(
                    child: BaseBlocConsumer<NotificationCubit, List<NotificationModel>>(
                      successBuilder: (not) => _NotificationList(not),
                      loadingBuilder: () => _NotificationList(List.generate(12, (_) => NotificationModel.fake())),
                      emptyBuilder: AppStates.empty,
                      failureBuilder: AppStates.error,
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



