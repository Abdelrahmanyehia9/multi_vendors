import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/enum/stock_availability.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import '../../../../../core/enum/product_tags.dart';
import '../../../../../core/models/category_model.dart';
import '../../../../../core/models/price_model.dart';
import '../../../../../core/models/variant_model.dart';
import '../../../../../core/utils/helper/fake_data.dart';

class ProductDetailsModel extends Equatable {
  final int? id ;
  final DateTime? createdAt ;
  final String? name;
   final VendorModel? vendor;
   final String? description;
   final List<VariantModel>? variants;
   final RatingModel? rating;
   final StockAvailability? stockAvailability;
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
    this.variants,
    this.rating,
  required this.price,
    this.stockAvailability,
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
        variants: json['variants'] != null
            ? List<VariantModel>.from(
                json['variants'].map((x) => VariantModel.fromJson(x)),
              )
            : null,
        rating: json['rating'] == null
            ? null
            : RatingModel.fromJson(json['rating']),
        price: PriceModel.fromJson(json),
        stockAvailability: StockAvailability.fromDatabase(
          json['stock_availability'],
        ),
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
  ProductDetailsModel copyWith({
    int? id,
    DateTime? createdAt,
    String? name,
    VendorModel? vendor,
    String? description,
    List<VariantModel>? variants,
    RatingModel? rating,
    PriceModel? price,
    StockAvailability? stockAvailability,
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
      variants: variants ?? this.variants,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      stockAvailability: stockAvailability ?? this.stockAvailability,
      ratingEnabled: ratingEnabled ?? this.ratingEnabled,
      category: category ?? this.category,
      images: images ?? this.images,
      thumbnail: thumbnail ?? this.thumbnail,
      productTags: productTags ?? this.productTags,
    );
  }
  List<String>? get sliderImages {
    late List<String>? slider;
    if (!images.isNullOrEmpty) {
      slider = images;
    }
    else {
      final result = variants
        ?.map((e) => e.images)
        .whereType<String>()
        .toList();
      slider = result ;
    }
    return [?thumbnail, ...?slider];
  }
  factory ProductDetailsModel.fake()=>ProductDetailsModel(
    images: const [],
    description: FakeData.fakeStringDesc,
    name: FakeData.fakeStringTitle,
    vendor: VendorModel.fake(),
    variants: const [],
    category: CategoryModel.fake(),
    thumbnail: FakeData.fakeImg,
    productTags: const [],
    rating: RatingModel.fake(),
    price: PriceModel.fake(),
    stockAvailability: StockAvailability.inStock,
    ratingEnabled: true,
    createdAt: FakeData.fakeDateTime
  ) ;


  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt?.toIso8601String(),
    "name": name,
    "vendor": vendor?.toJson(),
    "description": description,
    "variants": variants?.map((e) => e.toJson()).toList(),
    ...price.toJson(),
    "stock_availability": stockAvailability?.toDatabase,
    "rating_enabled": ratingEnabled,
    "category": category?.toJson(),
    "images": images,
    "thumbnail": thumbnail,
    "tags": productTags
        ?.map((e) => e.toDatabase)
        .toList(),
  }.withoutNulls;


  bool get  isAvailable =>  stockAvailability == StockAvailability.inStock || stockAvailability ==null;

  @override
  // TODO: implement props
  List<Object?> get props => [id, createdAt, name, vendor, description, variants, price, stockAvailability, ratingEnabled, category, images, thumbnail, productTags, rating];
}


