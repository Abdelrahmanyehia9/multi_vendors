
import 'package:easy_localization/easy_localization.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/app_strings.dart';

enum ProductSortByType{
  time,
  price,
  rating,
  name ;
  String get toDatabase => switch(this){
    time=> 'created_at',
    price=> 'price',
    rating=> 'rating',
    name=> 'name',
  };
  String toText(bool asc) => switch (this) {
    time =>
    asc ? AppStrings.oldestFirst.tr() : AppStrings.newestFirst.tr(),
    price => '${AppStrings.price.tr()}: ${   asc ?AppStrings.lowToHigh.tr() :AppStrings.highToLow.tr()}',
    rating =>
    '${AppStrings.rating.tr()}: ${   asc ?AppStrings.lowToHigh.tr() :AppStrings.highToLow.tr()}',
    name =>
  '${AppStrings.name.tr()}: ${   asc ?AppStrings.aToZ.tr() :AppStrings.zToA.tr()}',
  };
  String get text => switch (this) {
    time =>AppStrings.createdAt.tr(),
    price =>AppStrings.price.tr(),
    rating =>AppStrings.rating.tr(),
    name => AppStrings.name.tr(),
  };
}
class ProductSortBy{
  final ProductSortByType type;
  final bool asc;
  const ProductSortBy({required this.type,  this.asc =true});
  Map<String, dynamic> toJson() => {
    'p_sort_by': type.toDatabase,
    'p_sort_dir': asc? 'asc' : 'desc',
  }.withoutNulls;
}