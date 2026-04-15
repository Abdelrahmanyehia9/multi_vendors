import 'package:multi_vendor/core/enum/stock_availability.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/models/base_category_model.dart';
import 'package:multi_vendor/core/models/extension/variants.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_sort_by.dart';
import '../../../../../core/models/range_model.dart';
import '../../../../../core/models/variant_attributes_model.dart';


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
        ? VariantsAttributes.fromAny(
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
    "p_tags": tags?.map((e) => e.tag.toDatabase).toList(),
    "p_vendor_ids": vendors?.map((e) => e.id).toList(),
    "p_category_ids": categories?.map((e) => e.id).toList(),
    "p_rating_range": ratingRange?.toJson(),
    "p_price_range": priceRange?.toJson(),
     ...?sortBy?.toJson(),
   "p_stock_availability": stockAvailability?.map((e) => e.toDatabase).toList(),
    "p_attributes": attributes.isNullOrEmpty ? null
        : {
      for (var group in attributes!.groupedVariants)
        group.first.key: {"value": group.first.value}
    },
  }.withoutNulls;


}
