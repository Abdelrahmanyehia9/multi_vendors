import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


enum ProductTags {
  bestSelling,
  featured,
  healthy,
  bigSale,
  summerOffer,
  flashSale , blackFriday;

 static const Map<ProductTags, String> _map = {
   bestSelling: 'best_selling',
   featured: 'featured',
   summerOffer: 'summer_offers',
   healthy: 'healthy',
   flashSale: 'flash_sale',
   bigSale: 'big_sale',
   blackFriday: 'black_friday',
 };
  String get toDatabase => _map[this]??"best_selling";
  static ProductTags fromDatabase(String value) {
    return _map.entries.firstWhere((element) => element.value == value).key;
  }
   PostgrestTransformBuilder<PostgrestList> filters(PostgrestFilterBuilder<PostgrestList> q) =>
      switch (this) {
        bestSelling => q.contains('tags', ['best_selling']),
        featured    => q.contains('tags', ['featured']),
        summerOffer => q.contains('tags', ['summer_offers']),
        flashSale => q.contains('tags', ['flash_sale']),
        blackFriday => q.contains('tags', ['black_friday']),
        healthy     => q.contains('tags', ['healthy']),
        bigSale     => q.contains('tags', ['big_sale']),
      };
  String get toText => switch(this){
    ProductTags.bestSelling => AppStrings.bestSelling.tr(),
    ProductTags.featured    => AppStrings.featured.tr(),
    ProductTags.summerOffer => AppStrings.summerOffer.tr(),
    ProductTags.flashSale => AppStrings.flashSale.tr(),
    ProductTags.healthy     => AppStrings.healthyChoice.tr(),
    ProductTags.bigSale     => AppStrings.bigSale.tr(),
    ProductTags.blackFriday => AppStrings.blackFriday.tr(),
  };
  Color get color => switch(this){
 bestSelling => AppColors.error600,
 featured    => AppColors.info600,
 summerOffer => AppColors.primary600,
 flashSale => AppColors.success600,
 blackFriday => AppColors.warning,
 healthy     => AppColors.success,
 bigSale => AppColors.error
  };

 static List<ProductTags> get ribbons => [blackFriday,summerOffer, flashSale];

}