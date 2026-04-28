import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/shared/data/models/product_model.dart';

class ProductResponseModel {
  final List<ProductModel> products;
  final PaginationDataModel? pagination;

  const ProductResponseModel({required this.products, this.pagination});

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      ProductResponseModel(
        products: List<ProductModel>.from(
          json['products'].map((x) => ProductModel.fromJson(x)),
        ),
        pagination: PaginationDataModel.fromJson(json),
      );

  factory ProductResponseModel.fake() => ProductResponseModel(
    products: List.generate(8, (index) {
      return ProductModel.fake();
    }),
    pagination: PaginationDataModel.fake(),
  );
}

class PaginationDataModel {
  final int? total;
  final int? limit;
  final int? offset;

  PaginationDataModel({this.total, this.limit, this.offset});

  factory PaginationDataModel.fromJson(Map<String, dynamic> json) =>
      PaginationDataModel(
        total: json['total'],
        limit: json['limit'],
        offset: json['offset'],
      );

  factory PaginationDataModel.fake() => PaginationDataModel(
    total: FakeData.fakeInt,
    limit: FakeData.fakeInt,
    offset: FakeData.fakeInt,
  );
}
