import 'dart:ui';

import 'package:multi_vendor/core/theme/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


enum ProductTags {
  bestSelling,
  featured,
  healthy,

  summerOffer,
  newArrivals ;

 static const Map<ProductTags, String> _map = {
   bestSelling: 'best_selling',
   featured: 'featured',
   summerOffer: 'summer_offers',
   healthy: 'healthy',
   newArrivals: 'new_arrivals',
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
        newArrivals => q.contains('tags', ['new_arrivals']),
        healthy     => q.contains('tags', ['healthy']),
      };
  String get toText => switch(this){
    ProductTags.bestSelling => 'Best Selling',
    ProductTags.featured    => 'Featured',
    ProductTags.summerOffer => 'Summer Offer',
    ProductTags.newArrivals => 'New Arrivals',
    ProductTags.healthy     => 'Healthy Choice',
  };
  Color get color => switch(this){
 bestSelling => AppColors.error600,
 featured    => AppColors.info600,
 summerOffer => AppColors.primary600,
 newArrivals => AppColors.success600,
 healthy     => AppColors.success,
  };


}