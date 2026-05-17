import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

enum AppCurrency{
  dollar,
  egyptianPound ;

  String get text {
    if(this == dollar) return AppStrings.usd.tr();
    return AppStrings.egp.tr() ;
  }
  String get symbol{
    if(this == dollar) return "\$";
    return "£";
  }
  double get convertToDollar {
    if(this == dollar) return 1;
    return 0.15;
  }

  static AppCurrency fromDatabase(String data){
    if(data == "usd") return AppCurrency.dollar;
    return AppCurrency.egyptianPound;
  }


}