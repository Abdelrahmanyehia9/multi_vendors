part of '../notification_screen.dart';
class _NotificationScreenAction extends StatelessWidget {
  final List<int>selectedNotifications;
  const _NotificationScreenAction({required this.selectedNotifications});

  @override
  Widget build(BuildContext context) {
    final notificationsCubit = context.read<NotificationCubit>();
    final deleteCubit = context.read<NotificationDeleteCubit>();
    return BaseBlocConsumer(
      bloc: notificationsCubit,
      successBuilder: (s) => AppDeleteButton(
        onTap: () async => deleteNotifications(
          selectedNotifications,
          deleteCubit: deleteCubit,
          context: context,
        ),
      ),
      loadingBuilder: () => const AppDeleteButton(),
    );
  }
  Future<void> deleteNotifications(
      List<int> ids, {
        required NotificationDeleteCubit deleteCubit,
        required BuildContext context,
      }) async {
    if (ids.isEmpty) {
      Popups.showWarning(context, onConfirm: deleteCubit.deleteAllNotification);
      return;
    }
    await deleteCubit.deleteNotifications(ids);
  }
}
