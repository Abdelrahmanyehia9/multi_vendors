import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
/*



 */
class AppConstants {
  const AppConstants._();
  static const String appName = 'Multi Vendor';
  ///filters by or tags Like (outwear, formal, casual)
  static const String tagsString = "Fashion Style" ;
  static final ProductTags homeFeaturedItem = ProductTags.summerOffer ;
  static const AuthFormType authFormType = AuthFormType.mobile;
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
  static final Country initialCountry = "EG".toCountry;
  static const  String supabaseUrl ="https://rjhzydonszurlkfrnhdc.supabase.co";
  static const  String supabaseKey ="sb_publishable_rg0vpTC-CtVu69U8zcf1zg_3nggFbBG";
  static final List<PaymentOption> payments = [PaymentOption.store, PaymentOption.cod];
  static const String supportPhoneNumber = "0111111111";
  static const String supportEmail = "support@multi-vendor.com";
  static const String supportFacebook = "multiVendor";
  static const String supportWhatsApp = "multiVendor";
  static const String supportInstagram = "multiVendor";
  static const String supportTikTok = "multiVendor";
  static const String? appStoreId = null;
  static final AppCurrency currency = AppCurrency(name: AppStrings.usd.tr(), char: "\$");


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

}

class AppCurrency{
  final String name  ;
  final String char;
  const AppCurrency({required this.name, required this.char});
}