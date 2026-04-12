import 'package:multi_vendor/core/enum/stock_availability.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/models/base_category_model.dart';
import 'package:multi_vendor/core/models/variant_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import '../../../../../core/models/range_model.dart';
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
 String get text=>switch (this) {
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
  };
}


class ProductsFiltersModel {
  final List<ProductTagModel>? tags;
  final List<VendorModel>? vendors;
  final List<CategoryModel>? categories;
  final RangeModel? priceRange;
  final RangeModel? ratingRange;
  final List<StockAvailability>? stockAvailability;
  final int totalProducts;
  final List<VariantsAttributes>? attributes;
  final ProductSortBy? sortBy;
  const  ProductsFiltersModel({
     this.tags,
     this.vendors,
     this.categories,
     this.priceRange,
     this.ratingRange,
     this.stockAvailability,
     this.totalProducts = 0 ,
     this.attributes ,
     this.sortBy,
  });
  factory ProductsFiltersModel.fromJson(Map<String, dynamic> json) => ProductsFiltersModel(
  tags: json['tags']!=null ? List<ProductTagModel>.from(json['tags'].map((x) => ProductTagModel.fromJson(x))) : null,
  vendors: json['vendors']!=null ? List<VendorModel>.from(json['vendors'].map((x)=>VendorModel.fromJson(x))): null,
  categories: json['categories']!=null ? List<CategoryModel>.from(json['categories'].map((x)=>CategoryModel.fromJson(x))): null,
  ratingRange: json['rating_range']==null?null : RangeModel.fromJson(json['rating_range']),
  priceRange: json['price_range']==null?null : RangeModel.fromJson(json['price_range']),
  stockAvailability: json['stock_availability']!=null ? List.from(json['stock_availability'].map((x)=>StockAvailability.fromDatabase(x))) : null,
  totalProducts: json['total_products'] ?? 0,
    attributes: json['attributes'] != null
        ? VariantsAttributes.fromFilterMap(
      json['attributes'] as Map<String, dynamic>,
    )
        : null,
);
  factory ProductsFiltersModel.fake() => ProductsFiltersModel(
  tags: List.generate(3, (_)=>ProductTagModel.fake()),
  vendors: List.generate(3, (_)=>VendorModel.fake()),
  ratingRange: RangeModel.fake(),
  stockAvailability: StockAvailability.values,
  totalProducts: FakeData.fakeInt,
);

  ProductsFiltersModel copyWith({
    List<ProductTagModel>? tags,
    List<VendorModel>? vendors,
    List<CategoryModel>? categories,
    RangeModel? ratingRange,
    RangeModel? priceRange,
    List<StockAvailability>? stockAvailability,
    int? totalProducts,
    List<VariantsAttributes>? attributes,
    ProductSortBy? sortBy,
  }) {
    return ProductsFiltersModel(
      tags: tags ?? this.tags,
      vendors: vendors ?? this.vendors,
      categories: categories ?? this.categories,
      ratingRange: ratingRange ?? this.ratingRange,
      priceRange: priceRange ?? this.priceRange,
      stockAvailability: stockAvailability ?? this.stockAvailability,
      totalProducts: totalProducts ?? this.totalProducts,
      attributes: attributes ?? this.attributes,
      sortBy: sortBy ?? this.sortBy,
    );
  }

  Map<String, dynamic> toJson() => {
    if(!tags.isNullOrEmpty)"p_tags": tags?.map((e) => e.tag.toDatabase).toList(),
    if(!vendors.isNullOrEmpty)"p_vendor_ids": vendors?.map((e) => e.id).toList(),
    if(!categories.isNullOrEmpty)"p_category_ids": categories?.map((e) => e.id).toList(),
    "p_rating_range": ratingRange?.toJson(),
    "p_price_range": priceRange?.toJson(),
   if(sortBy != null) ...?sortBy?.toJson(),
    if(!stockAvailability.isNullOrEmpty)"p_stock_availability": stockAvailability?.map((e) => e.toDatabase).toList(),
    "p_attributes": attributes.isNullOrEmpty ? null
        : {
      for (var group in attributes!.groupedVariants)
        group.first.key: {"value": group.first.value}
    },
  };

  @override
  String toString() {
    return 'ProductsFiltersModel(tags: ${tags?.map((e) => e.tag.name)}, vendors: ${vendors?.map((e) => e.name)}, categories: ${categories?.map((e) => e.name)}, ratingRange: ${ratingRange.toString()}, priceRange: ${priceRange.toString()}, stockAvailability: ${stockAvailability?.map((e) => e.toText)}, totalProducts: $totalProducts, attributes: ${
    attributes?.groupedVariants.map((g) => "${g.first.key}: ${g.map((e) => e.description ?? e.value).join(", ")}").join(", ")
    })';
  }
  List<String> get toChips=>[
    if(priceRange!=null)...[
      "From ${priceRange!.min.round().usdPrice}",
      "To ${priceRange!.max.round().usdPrice}"
    ],
    if(ratingRange!=null)
      "Over ${ratingRange!.min} ⭐",
    if(!stockAvailability.isNullOrEmpty)...[
      for(var s in stockAvailability!)
      s.toText
    ],
    if(!categories.isNullOrEmpty)...[
      for(var c in categories!)
      c.name
    ],
    if(!vendors.isNullOrEmpty)...[
      for(var v in vendors!)
      v.name
    ],
    if(!tags.isNullOrEmpty)...[
      for(var t in tags!)
      t.name
    ],
    if(!attributes.isNullOrEmpty)...[
      for(var g in attributes!.groupedVariants)
        "${g.first.key} : ${g.map((e) => e.description??e.value).join(", ")}"
    ],
    if(sortBy!=null)
      sortBy!.type.text+ (sortBy!.asc?"↑":"↓"),
  ] ;
}



