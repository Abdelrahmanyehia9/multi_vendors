import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/service/navigation_service.dart';
import 'package:multi_vendor/features/notifications/data/model/notification_payload.dart';

class NotificationRedirectHelper {
const NotificationRedirectHelper._();
  static final NotificationRedirectHelper _instance = const NotificationRedirectHelper._();
  static  NotificationRedirectHelper get instance => _instance;


  void redirect(NotificationPayload? payload){
    if(payload==null) return;
   if(payload.redirect == null) {
     return ;
   }
   else if (payload.redirect!.contains("orderDetails")){
     NavigationService.navigator?.pushNamed(Routes.orderDetails, arguments: payload.id);
   }
  }

}

