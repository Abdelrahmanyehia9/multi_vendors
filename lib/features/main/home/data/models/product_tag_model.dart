import 'package:multi_vendor/core/enum/product_tags.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';

class ProductTagModel {
  final ProductTags tag;
  final String? thumbnail;
  final int count;

  const ProductTagModel({
    required this.tag,
    this.thumbnail,
    required this.count,
  });

  factory ProductTagModel.fromJson(Map<String, dynamic> json) =>
      ProductTagModel(
        tag: ProductTags.fromDatabase(json['type']),
        thumbnail: json['image'] as String?,
        count: json['count'] as int,
      );

  Map<String, dynamic> toJson() => {
    'type': tag.toDatabase,
    'image': thumbnail,
    'count': count,
  }.withoutNulls;

  ProductTagModel copyWith({
    ProductTags? tag,
    String? thumbnail,
    int? count,
  }) {
    return ProductTagModel(
      tag: tag ?? this.tag,
      thumbnail: thumbnail ?? this.thumbnail,
      count: count ?? this.count,
    );
  }

  factory ProductTagModel.fake()=>const ProductTagModel(
    tag: ProductTags.bestSelling,
    count: 0,
  );
  String get name => tag.toText;
}