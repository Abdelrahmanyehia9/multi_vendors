import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/enum/login_providers.dart';
import 'package:multi_vendor/core/types/type_def.dart';
/*



 */
class AppConstants {
  const AppConstants._();
  static const String appName = 'Multi Vendor';
  ///filters by or tags Like (outwear, formal, casual)
  static const String tagsString = "Fashion Style" ;
  static const ProductTags homeFeaturedItem = ProductTags.summerOffer ;
  static const AuthFormType authFormType = AuthFormType.mobile;
  static const List<OnBoardingItemData> items = [
    (
    title: "Collection of Your Favorite \nBest",
    description: "Step into a world of fashion made just for you. Explore curated looks, trending outfits, and timeless pieces that match your personality and elevate your everyday style.",
    imagePath: AppAssets.onBoarding1,
    titleHighlighter: "Fashion",
    ),
    (
    title: "Choose Your",
    description: "Tell us who you're shopping for so we can tailor every recommendation to your taste. Whether it's for men, women, or kids — we’ve got something perfect waiting for you.",
    imagePath: AppAssets.onBoarding2,
    titleHighlighter: 'Brand'
    ),
    (
    title: "Shop the Latest Trends",
    description: "Stay ahead with the newest collections from top brands. From casual essentials to standout pieces, discover everything you need to build your perfect wardrobe.",
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