import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/enum/payment_option.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import 'package:multi_vendor/core/utils/testing.dart';
import '../enum/login_providers.dart';
import '../types/type_def.dart';
/*



 */
class AppConstants {
  const AppConstants._();
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
  static const String appName = 'Multi Vendor';
  ///filters by or tags Like (outwear, formal, casual)
  static const String tagsString = "Fashion Style" ;
  static const ProductTags homeFeaturedItem = ProductTags.summerOffer ;
  static const AuthFormType authFormType = AuthFormType.mobile;
  static const List<OnBoardingItemData> items = [
    (
    title: "Collection of Your Favorite \nBest",
    description: "Arancia provides the best and most contemporary outfits to meet your fashion needs",
    imagePath: Testing.menShirt,
    titleHighlighter: "Fashion",
    ),
    (
    title: "second title",
    description: "second desctiption",
    imagePath: Testing.girlModel,
    titleHighlighter: null
    ),
    (
    title: "third title",
    description: "third desctiption",
    imagePath: Testing.menShirt,
    titleHighlighter: null
    ),
  ];
  static final Country initialCountry = "EG".toCountry;
  static const  String supabaseUrl ="https://rjhzydonszurlkfrnhdc.supabase.co";
  static const  String supabaseKey ="sb_publishable_rg0vpTC-CtVu69U8zcf1zg_3nggFbBG";
  static final List<PaymentOption> payments = [PaymentOption.store, PaymentOption.cod];

}