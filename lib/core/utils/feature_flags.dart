
import 'package:flutter/cupertino.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';

class FeatureFlags {
 const FeatureFlags._();
static  bool multiVendor = false;
static  bool shopByTags = false;
static  bool hasNews = false;
static  bool enableProductVariants = false;
static  bool enableMultiShipping = false;
static  bool enableProductFilters = false;
static  bool enableForgetPassword = false;
static  bool enableMultiLanguage = false;
static  bool enableVoucher = false;
static  bool enableRating = false;
static  bool enableFavorite = false ;
static  bool enablePayments = false;
static bool enableNotification = true;



 static Future<void> init() async {
  try {
   final response = await getIt.get<DatabaseService>().GET_SINGLE(
    table: "app_config",
    select: "features",
    timeout: const Duration(seconds: 10),
    filter: (q)=>q.eq(RemoteDatabaseConstants.is_active_column, true)
   );
   if (response.isEmpty) return;
   final Map<String, dynamic> features = response['features'];
   multiVendor            = features['multi_vendor']             ?? multiVendor;
   shopByTags             = features['shop_by_tags']             ?? shopByTags;
   hasNews                = features['has_news']                 ?? hasNews;
   enableProductVariants  = features['enable_product_variants']  ?? enableProductVariants;
   enableMultiShipping    = features['enable_multi_shipping']    ?? enableMultiShipping;
   enableProductFilters   = features['enable_product_filters']   ?? enableProductFilters;
   enableForgetPassword   = features['enable_forget_password']   ?? enableForgetPassword;
   enableMultiLanguage    = features['enable_multi_language']    ?? enableMultiLanguage;
   enableVoucher          = features['enable_voucher']           ?? enableVoucher;
   enableRating           = features['enable_rating']            ?? enableRating;
   enableFavorite         = features['enable_favorite']          ?? enableFavorite;
   enablePayments         = features['enable_payments']          ?? enablePayments;
   ///TO DO
   enableNotification         = features['enable_notifications'] ?? enableNotification;
  } catch (e) {
   debugPrint(e.toString());
   return;
  }
 }

}


