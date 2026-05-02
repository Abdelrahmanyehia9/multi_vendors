import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/enum/stock_availability.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/shared/data/models/category_model.dart';
import 'package:multi_vendor/shared/data/models/price_model.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';
import 'package:multi_vendor/shared/data/models/stock_availabilty_model.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';

class ProductDetailsModel extends Equatable {
  final int? id ;
  final DateTime? createdAt ;
  final String? name;
   final VendorModel? vendor;
   final String? description;
   final RatingModel? rating;
   final StockAvailabilityModel? inStock;
   final PriceModel price ;
   final bool? ratingEnabled;
   final CategoryModel? category;
   final List<String>? images;
   final String? thumbnail;
   final List<ProductTags>? productTags;
  const ProductDetailsModel({
    this.id,
    this.createdAt,
    this.name,
    this.vendor,
    this.description,
    this.rating,
  required this.price,
    this.inStock,
    this.ratingEnabled,
    this.category,
    this.images,
    this.thumbnail,
    this.productTags,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: json['id'],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        name: json['name'],
        vendor: json['vendor'] == null ? null : VendorModel.fromJson(json['vendor']),
        description: json['description'],
        rating: json['rating'] == null
            ? null
            : RatingModel.fromJson(json['rating']),
        price: PriceModel.fromJson(json),
        inStock: json['in_stock'] == null ? null : StockAvailabilityModel(quantity: json['in_stock']),
        ratingEnabled: json['rating_enabled'],
        category: json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        images: json['images'] == null ? null : List<String>.from(json['images']),
        thumbnail: json['thumbnail'],
        productTags: json['tags'] != null
            ? List<ProductTags>.from(
                json['tags'].map(
                  (x) =>
                      ProductTags.values.firstWhere((e) => e.toDatabase == x),
                ),
              )
            : null,
      );
  factory ProductDetailsModel.fake()=>ProductDetailsModel(
      images: const [],
      id: FakeData.fakeInt,
      description: FakeData.fakeStringDesc,
      name: FakeData.fakeStringTitle,
      vendor: VendorModel.fake(),
      category: CategoryModel.fake(),
      thumbnail: FakeData.fakeImg,
      productTags: const [],
      rating: RatingModel.fake(),
      price: PriceModel.fake(),
      inStock: StockAvailabilityModel(quantity: FakeData.fakeInt),
      ratingEnabled: true,
      createdAt: FakeData.fakeDateTime
  ) ;

  ProductDetailsModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    VendorModel? vendor,
    String? description,
    RatingModel? rating,
    PriceModel? price,
    StockAvailabilityModel? inStock,
    bool? ratingEnabled,
    CategoryModel? category,
    List<String>? images,
    String? thumbnail,
    List<ProductTags>? productTags,
  }) {
    return ProductDetailsModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      vendor: vendor ?? this.vendor,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      inStock: inStock ?? this.inStock,
      ratingEnabled: ratingEnabled ?? this.ratingEnabled,
      category: category ?? this.category,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      productTags: productTags ?? this.productTags,
    );
  }


  bool get isInStock => inStock?.type==StockAvailability.inStock;




  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "name": name,
    "vendor": vendor?.toJson(),
    "description": description,
    ...price.toJson(),
    "in_stock": inStock?.quantity,
    "rating_enabled": ratingEnabled,
    "category": category?.toJson(),
    "images": images,
    "thumbnail": thumbnail,
    "tags": productTags
        ?.map((e) => e.toDatabase)
        .toList(),
  }.withoutNulls;

  List<String>? get sliderImages {
    List<String>? slider;
    if (!images.isNullOrEmpty) {
      slider = images;
    }
    return [?thumbnail, ...?slider];
  }

  @override
  List<Object?> get props => [id, createdAt, name, vendor, description, price, inStock, ratingEnabled, category, images, thumbnail, productTags, rating];
}


