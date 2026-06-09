import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/shop/product/data/model/product_details_model.dart';
import 'package:multi_vendor/shared/data/models/price_model.dart';
import 'package:multi_vendor/shared/data/models/rating_model.dart';
import 'package:multi_vendor/shared/data/models/stock_availabilty_model.dart';
import 'package:multi_vendor/shared/data/models/vendor_model.dart';
import 'package:multi_vendor/features/main/favorite/data/model/favorite_item.dart';

class ProductModel extends Equatable implements FavoriteItem {
  final int? id;
  final RatingModel? rating;
  final PriceModel? price;
  final List<ProductTags>? productTags;
  final Map<String, dynamic> name;
  final String? thumbnail;
  final VendorModel? vendor;
  final StockAvailabilityModel? stockAvailability;

  const ProductModel({
    this.id,
    this.rating,
    required this.name,
    required this.price,
    this.stockAvailability,
    this.productTags,
    this.thumbnail,
    this.vendor,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    name: json['name'],
    price: json['price'] is Map
        ? PriceModel.fromJson(json['price'])
        : PriceModel.fromJson(json),
    productTags: json["tags"] == null
        ? null
        : (json['tags'] as List)
        .map((e) => ProductTags.fromDatabase(e))
        .toList(),
    thumbnail: json['thumbnail'],
    stockAvailability: json['in_stock'] == null
        ? null
        : StockAvailabilityModel(quantity: json['in_stock']),
    vendor:
    json['vendor'] == null ? null : VendorModel.fromJson(json['vendor']),
    rating:
    json['rating'] == null ? null : RatingModel.fromJson(json['rating']),
  );

  factory ProductModel.fake() => ProductModel(
    id: FakeData.fakeInt,
    name: const {},
    price: PriceModel.fake(),
    productTags: const [],
    thumbnail: FakeData.fakeImg,
    vendor: VendorModel.fake(),
    rating: RatingModel.fake(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (price != null) ...price!.toJson(),
    'tags': productTags?.map((e) => e.toDatabase).toList(),
    'thumbnail': thumbnail,
    'in_stock': stockAvailability?.quantity,
    'vendor': vendor?.toJson(),
    'rating': rating?.toJson(),
  };

  factory ProductModel.fromProductDetails(ProductDetailsModel model) =>
      ProductModel(
        name: model.name,
        price: model.price,
        id: model.id,
        thumbnail: model.thumbnail,
        vendor: model.vendor,
        rating: model.rating,
        stockAvailability: model.inStock,
        productTags: model.productTags,
      );

  @override
  List<Object?> get props => [id, rating, price, productTags, name, thumbnail, vendor];
  int get uniqueId => id!;
  int get inStock => stockAvailability?.quantity ?? 0;
  ProductTags? get ribbon => productTags?.firstWhereOrNull((e) => ProductTags.ribbons.contains(e));
  bool get sponsored => vendor?.isSponsored ?? false;

  @override
  int get favoriteId => id!;
  @override
  Map<String, dynamic>? get favoriteName => name;
  @override
  FavoriteType get favoriteType => FavoriteType.product;
}