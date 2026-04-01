import 'package:supabase_flutter/supabase_flutter.dart';


enum ProductTags {
  bestSelling,
  featured,
  healthy,

  summerOffer,
  newArrivals ;

 static const Map<ProductTags, String> _map = {
   ProductTags.bestSelling: 'best_selling',
   ProductTags.featured: 'featured',
   ProductTags.summerOffer: 'summer_offers',
   ProductTags.healthy: 'healthy',
   ProductTags.newArrivals: 'new_arrivals',
 };
  String get toDatabase => _map[this]??"best_selling";
  static ProductTags fromDatabase(String value) {
    return _map.entries.firstWhere((element) => element.value == value).key;
  }
   PostgrestTransformBuilder<PostgrestList> filters(PostgrestFilterBuilder<PostgrestList> q) =>
      switch (this) {
        ProductTags.bestSelling => q.contains('tags', ['best_selling']),
        ProductTags.featured    => q.contains('tags', ['featured']),
        ProductTags.summerOffer => q.contains('tags', ['summer_offer']),
        ProductTags.newArrivals => q.contains('tags', ['new_arrivals']),
        ProductTags.healthy     => q.contains('tags', ['healthy']),
      };
  String get toText => switch(this){
    ProductTags.bestSelling => 'Best Selling',
    ProductTags.featured    => 'Featured',
    ProductTags.summerOffer => 'Summer Offer',
    ProductTags.newArrivals => 'New Arrivals',
    ProductTags.healthy     => 'Healthy Choice',
  };


}