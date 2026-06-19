import 'package:multi_vendor/core/types/type_def.dart';
import 'package:multi_vendor/core/utils/app_assets.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

class AppConstants {
  const AppConstants._();
  static const String slogan = AppStrings.discoverYourBest ;
  static const String sloganHighlight = AppStrings.fashion ;
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
  static const  String supabaseUrl ="https://rjhzydonszurlkfrnhdc.supabase.co";
  static const  String supabaseKey ="sb_publishable_rg0vpTC-CtVu69U8zcf1zg_3nggFbBG";
  static const String privacyPolicyUrl = "https://sites.google.com/view/avera-privacy/";
  static const String? appStoreId = null;
  static const String onesignalAppId = "c9e7fc5b-2149-46cd-82a3-3d1f287e783b";

  static final  appName = AppStrings.appName;

}