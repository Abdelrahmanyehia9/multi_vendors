import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/models/base_category_model.dart';
import 'package:multi_vendor/core/models/price_model.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/models/variant_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';

import '../enum/product_tags.dart';
import '../enum/stock_availability.dart';

class BaseProductModel extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final String? name;
  final VendorModel? vendor;
  final String? description;
  final PriceModel? price;
  final StockAvailability? stockAvailability;
  final bool? ratingEnabled;
  final CategoryModel? category;
  final List<String>? images;
  final String? thumbnail;
  final List<ProductTags>? productTags;
  final List<VariantModel>? variants;
  final RatingModel? rating;

  const BaseProductModel({
     this.id,
     this.createdAt,
     this.name,
     this.vendor,
     this.description,
     this.variants,
    this.rating,
     this.price,
     this.stockAvailability,
     this.ratingEnabled,
     this.category,
     this.images,
     this.thumbnail,
     this.productTags,
  });

  @override
  List<Object?> get props => [id,rating,variants ,createdAt, name, vendor, description, price, stockAvailability, ratingEnabled, category, images, thumbnail, productTags];
}
