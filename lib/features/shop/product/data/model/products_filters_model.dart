import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/main/home/data/models/product_tag_model.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_sort_by.dart';
import 'package:multi_vendor/shared/data/models/category_model.dart';
import 'package:multi_vendor/shared/data/models/range_model.dart';
import 'package:multi_vendor/shared/data/models/stock_availabilty_model.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';


class ProductsFiltersModel {
  final List<ProductTagModel>? tags;
  final List<VendorModel>? vendors;
  final List<CategoryModel>? categories;
  final RangeModel? priceRange;
  final RangeModel? ratingRange;
  final int totalProducts;
  final ProductSortBy? sortBy;
  final StockAvailabilityModel? stockAvailability;
  const  ProductsFiltersModel({
    this.tags,
    this.vendors,
    this.categories,
    this.stockAvailability,
    this.priceRange,
    this.ratingRange,
    this.totalProducts = 0 ,
    this.sortBy,
  });
  factory ProductsFiltersModel.fromJson(Map<String, dynamic> json) => ProductsFiltersModel(
    tags: json['tags']!=null ? List<ProductTagModel>.from(json['tags'].map((x) => ProductTagModel.fromJson(x))) : null,
    vendors: json['vendors']!=null ? List<VendorModel>.from(json['vendors'].map((x)=>VendorModel.fromJson(x))): null,
    categories: json['categories']!=null ? List<CategoryModel>.from(json['categories'].map((x)=>CategoryModel.fromJson(x))): null,
    ratingRange: json['rating_range']==null?null : RangeModel.fromJson(json['rating_range']),
    priceRange: json['price_range']==null?null : RangeModel.fromJson(json['price_range']),
    totalProducts: json['total_products'] ?? 0,
  );
  factory ProductsFiltersModel.fake() => ProductsFiltersModel(
    tags: List.generate(3, (_)=>ProductTagModel.fake()),
    vendors: List.generate(3, (_)=>VendorModel.fake()),
    ratingRange: RangeModel.fake(),
    totalProducts: FakeData.fakeInt,
    stockAvailability: StockAvailabilityModel(quantity: FakeData.fakeInt),
  );

  ProductsFiltersModel copyWith({
    List<ProductTagModel>? tags,
    List<VendorModel>? vendors,
    List<CategoryModel>? categories,
    RangeModel? ratingRange,
    RangeModel? priceRange,
    StockAvailabilityModel? stockAvailability,
    int? totalProducts,
    ProductSortBy? sortBy,
  }) {
    return ProductsFiltersModel(
      tags: tags ?? this.tags,
      vendors: vendors ?? this.vendors,
      categories: categories ?? this.categories,
      ratingRange: ratingRange ?? this.ratingRange,
      priceRange: priceRange ?? this.priceRange,
      totalProducts: totalProducts ?? this.totalProducts,
      sortBy: sortBy ?? this.sortBy,
      stockAvailability: stockAvailability ?? this.stockAvailability,
    );
  }

  Map<String, dynamic> toJson() => {
    "p_tags": tags?.map((e) => e.tag.toDatabase).toList(),
    "p_vendor_ids": vendors?.map((e) => e.id).toList(),
    "p_category_ids": categories?.map((e) => e.id).toList(),
    "p_rating_range": ratingRange?.toJson(),
    "p_price_range": priceRange?.toJson(),
     ...?sortBy?.toJson(),
    "p_stock_availability": stockAvailability?.quantity,
  }.withoutNulls;


}
