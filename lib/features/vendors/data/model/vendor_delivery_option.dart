import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/shared/data/models/range_model.dart';

class VendorDeliveryOptionModel {
  final RangeModel estimatedDeliveryTime;
  final num? deliveryFees;
  final bool deliveryByStore;
  final bool enabled;

  const VendorDeliveryOptionModel({
    required this.estimatedDeliveryTime,
    required this.deliveryFees,
    required this.deliveryByStore,
    required this.enabled,
  });

  factory VendorDeliveryOptionModel.fromJson(Map<String, dynamic>json)=>
      VendorDeliveryOptionModel(
          estimatedDeliveryTime:  RangeModel.fromJson(json['delivery_time']),
          deliveryFees: json['fees'],
          deliveryByStore: json['delivery_by_store']??false,
          enabled: json['available']);

  factory VendorDeliveryOptionModel.fake()=>
      VendorDeliveryOptionModel(
          estimatedDeliveryTime:  RangeModel.fake(),
          deliveryFees: FakeData.fakeDouble,
          deliveryByStore: FakeData.fakeBoolean,
          enabled: FakeData.fakeBoolean
      );


}
