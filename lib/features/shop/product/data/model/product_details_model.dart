import 'package:multi_vendor/core/enum/stock_availability.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';

import '../../../../../core/enum/product_tags.dart';
import '../../../../../core/models/base_category_model.dart';
import '../../../../../core/models/base_product_model.dart';
import '../../../../../core/models/price_model.dart';
import '../../../../../core/models/variant_model.dart';
import '../../../../../core/utils/helper/fake_data.dart';

class ProductDetailsModel extends BaseProductModel {
  const ProductDetailsModel({
    super.id,
    super.createdAt,
    super.name,
    super.vendor,
    super.description,
    super.variants,
    super.rating,
    super.price,
    super.stockAvailability,
    super.ratingEnabled,
    super.category,
    super.images,
    super.thumbnail,
    super.productTags,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsModel(
        id: json['id'],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        name: json['name'],
        vendor: VendorModel.fromJson(json['vendor']),
        description: json['description'],
        variants: json['variants'] != null
            ? List<VariantModel>.from(
                json['variants'].map((x) => VariantModel.fromJson(x)),
              )
            : null,
        rating: json['rating'] == null
            ? null
            : RatingModel.fromJson(json['rating']),
        price: json["price"] == null
            ? null
            : PriceModel.fromJson(json['price']),
        stockAvailability: StockAvailability.fromDatabase(
          json['stock_availability'],
        ),
        ratingEnabled: json['rating_enabled'],
        category: json['category'] != null
            ? CategoryModel.fromJson(json['category'])
            : null,
        images: List<String>.from(json['images']),
        thumbnail: json['thumbnail'],
        productTags: json['product_tags'] != null
            ? List<ProductTags>.from(
                json['product_tags'].map(
                  (x) =>
                      ProductTags.values.firstWhere((e) => e.toDatabase == x),
                ),
              )
            : null,
      );


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

}
