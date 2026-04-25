import 'package:multi_vendor/core/models/category_model.dart';
import 'package:multi_vendor/core/models/rating_model.dart';
import 'package:multi_vendor/core/models/vendor_model.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/vendors/data/model/vendor_delivery_option.dart';

class VendorDetailsModel extends VendorModel {
  final List<CategoryModel>? categories;
  final RatingModel? vendorRating;
  final VendorDeliveryOptionModel? deliveryOption;
  final bool isVerified;

  const VendorDetailsModel({
    this.categories,
    this.vendorRating,
    this.deliveryOption,
    this.isVerified =false,
    super.id,
    required super.name,
    required super.image,
  });

  factory VendorDetailsModel.fromJson(Map<String, dynamic> json) =>
      VendorDetailsModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        isVerified: json['is_verified'] ?? false,
        categories: json['categories'] != null
            ? List<CategoryModel>.from(json['categories'].map((x) => CategoryModel.fromJson(x)))
            : null,
        vendorRating: json['rating'] == null
            ? null
            : RatingModel.fromJson(json['rating']),
        deliveryOption: json['delivery_option'] == null
            ? null
            : VendorDeliveryOptionModel.fromJson(json['delivery_option']),

      );
  factory VendorDetailsModel.fake() =>
      VendorDetailsModel(
        name: "",
        image: FakeData.fakeImg,
        categories:  List<CategoryModel>.generate(10, (index) => CategoryModel.fake()),
        isVerified: FakeData.fakeBoolean,
        vendorRating:RatingModel.fake(),
        deliveryOption: VendorDeliveryOptionModel.fake(),

      );



  bool get hasInfo => categories != null || vendorRating != null || deliveryOption != null;
}

