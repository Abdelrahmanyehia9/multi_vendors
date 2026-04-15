
import 'package:multi_vendor/core/extensions/data_type.dart';

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
    asc ? 'Oldest first' : 'Newest first',
    price =>
    asc ? 'Price: Low to High' : 'Price: High to Low',
    rating =>
    asc ? 'Rating: Low to High' : 'Rating: High to Low',
    name =>
    asc ? 'Name: A to Z' : 'Name: Z to A',
  };
  String get text => switch (this) {
    time =>"Created at",
    price =>'Price',
    rating =>"ratings",
    name => 'alphabetical',
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