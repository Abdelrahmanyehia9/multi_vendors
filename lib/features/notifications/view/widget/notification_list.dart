part of '../notification_screen.dart';
class _NotificationList extends StatelessWidget {
  final List<NotificationModel> notifications ;
  const _NotificationList(this.notifications);

  @override
  Widget build(BuildContext context) {
    return SelectionBuilder<int>(
      builder:(state, cubit)=> ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (_, i) =>  AppClick(
            onLongPress: ()=>cubit.toggle(notifications[i].id),
            onTap: () {
              if(state.isSelectionMode) return cubit.toggle(notifications[i].id);
              NotificationRedirectHelper.instance.redirect(notifications[i].payload);
            },
            child: _NotificationItem(
                isSelected: state.isSelected(notifications[i].id),
                notifications[i]).paddingVr(4),),
        itemCount: notifications.length,
      ),
    ) ;
  }
}
