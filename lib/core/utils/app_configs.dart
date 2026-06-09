import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/enum/currency.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
class AppConfigs {
  const AppConfigs._();

  static  ProductTags? homeFeaturedItem  ;
  static  AuthFormType authFormType = AuthFormType.emailAndPassword;
  static List<SocialMediaAuth> socialAuth = [] ;
  static  Country initialCountry = "EG".toCountry;
  static List<int> vendorBoost = [] ;
  static  List<PaymentOption> payments = [PaymentOption.cod];
  static  String supportPhoneNumber = "0111111111";
  static  String supportEmail = "support@multi-vendor.com";
  static  String supportFacebook = "multiVendor";
  static  String supportWhatsApp = "multiVendor";
  static  String supportInstagram = "multiVendor";
  static  String supportTikTok = "multiVendor";
  static final AppCurrency currency = AppCurrency.dollar;
  static String? locale ;
  static int otpColdDown = 10;
  static PackageInfo? packageInfo;
  static String requiredBuild ='0';
  static bool isMaintenance = false;

  static Future<void> setupPhoneSystem() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemStatusBarContrastEnforced: false,
        systemNavigationBarContrastEnforced: false,
        statusBarColor: Colors.transparent,
      ),
    );
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  static Future<void> _initPackageInfo()async{
   packageInfo = await PackageInfo.fromPlatform() ;
  }


  static Future<void> init() async {
    try {
      await _initPackageInfo();
      final response = await getIt.get<DatabaseService>().GET_SINGLE(
          table: "app_config",
          select: "configs,requirements,vendor_boost",
          filter: (q)=>q.eq(RemoteDatabaseConstants.is_active_column, true)
      );
      if (response.isEmpty) return;
      final Map<String, dynamic> config = response['configs'];
      final Map<String, dynamic> requirements = response['requirements'];
      homeFeaturedItem  =    config['home_feature_item'] != null ?  ProductTags.fromDatabase(config['home_feature_item'])             : homeFeaturedItem;
      authFormType    =        config['auth_form_type'] !=null ?     AuthFormType.fromDatabase(config['auth_form_type'])             : authFormType;
      initialCountry    =      (config['country']as String?)?.toCountry?? initialCountry ;
      payments  =  config['payment_options']!=null?       List.from(config['payment_options']as List).map((e)=>PaymentOption.fromDatabase(e)).toList()  : payments;
      supportPhoneNumber    = config['support_phone']    ?? supportPhoneNumber;
      supportFacebook   = config['support_facebook']   ?? supportFacebook;
      supportEmail   = config['support_email']   ?? supportEmail;
      supportTikTok    = config['support_tiktok']    ?? supportTikTok;
      supportInstagram          = config['support_instagram']           ?? supportInstagram;
      supportWhatsApp           = config['support_whatsapp']            ?? supportWhatsApp;
      otpColdDown               = config['otp_cold_down']          ?? otpColdDown;
      requiredBuild = requirements['build'] ?? requiredBuild;
      isMaintenance = requirements['is_maintenance'] ?? isMaintenance;
      vendorBoost = response['vendor_boost'] != null ? List<int>.from(response['vendor_boost']) : vendorBoost;
      ///TO DO
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }}

