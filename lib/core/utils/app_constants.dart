import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/enum/currency.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
/*



 */
class AppConstants {
  const AppConstants._();
  static const String slogan = AppStrings.discoverYourBest ;
  static const String sloganHighlight = AppStrings.fashion ;
  static  ProductTags homeFeaturedItem = ProductTags.summerOffer ;
  static  AuthFormType authFormType = AuthFormType.emailAndPassword;
  static List<SocialMediaAuth> socialAuth = [] ;
  static const List<OnBoardingItemData> items = [
    (
    title: AppStrings.onBoarding1Title,
    description: AppStrings.onBoarding1description,
    imagePath: AppAssets.onBoarding1,
    titleHighlighter: AppStrings.onBoarding1HighLight,
    ),
    (
    title: AppStrings.onBoarding2Title,
    description: AppStrings.onBoarding2description,
    imagePath: AppAssets.onBoarding2,
    titleHighlighter: AppStrings.onBoarding2HighLight,
    ),
    (
    title: AppStrings.onBoarding3Title,
    description: AppStrings.onBoarding3description,
    imagePath: AppAssets.onBoarding3,
    titleHighlighter: null
    ),
  ];
  static  Country initialCountry = "EG".toCountry;
  static const  String supabaseUrl ="https://rjhzydonszurlkfrnhdc.supabase.co";
  static const  String supabaseKey ="sb_publishable_rg0vpTC-CtVu69U8zcf1zg_3nggFbBG";
  static  List<PaymentOption> payments = [PaymentOption.cod];
  static  String supportPhoneNumber = "0111111111";
  static  String supportEmail = "support@multi-vendor.com";
  static  String supportFacebook = "multiVendor";
  static  String supportWhatsApp = "multiVendor";
  static  String supportInstagram = "multiVendor";
  static  String supportTikTok = "multiVendor";
  static const String? appStoreId = null;
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
          select: "configs,requirements",
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
      ///TO DO
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }}

