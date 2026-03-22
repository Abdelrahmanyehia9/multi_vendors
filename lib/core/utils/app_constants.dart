import 'package:multi_vendor/core/utils/testing.dart';

import '../enum/login_providers.dart';
import '../types/type_def.dart';

class AppConstants {
  const AppConstants._();
  static const String appName = 'Multi Vendor';
  ///filters by or tags Like (outwear, formal, casual)
  static const String tagsString = "Fashion Style" ;
  static const AuthFormType authFormType = AuthFormType.emailAndPassword;
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
  static const  String supabaseUrl ="https://rjhzydonszurlkfrnhdc.supabase.co";
  static const  String supabaseKey ="sb_publishable_rg0vpTC-CtVu69U8zcf1zg_3nggFbBG";

}