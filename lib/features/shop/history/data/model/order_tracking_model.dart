import 'package:multi_vendor/core/enum/order_status.dart';

import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';

class OrderTrackingModel {
  final int? id;
  final TrackStatus status;
  final DateTime? createdAt;
  final UserModel? captain;

  const OrderTrackingModel({
     this.id,
    required this.status,
     this.createdAt,
     this.captain,
  });


  factory OrderTrackingModel.fromJson(Map<String, dynamic>json)=>OrderTrackingModel(
     id:  json['id'],
     createdAt: json['created_at']==null ?  null : DateTime.parse(json['created_at']) ,
      status: json['status']==null ?  TrackStatus.processing : TrackStatus.fromDatabase(json['status']),
      captain: json['captain']==null ? null : UserModel.fromJson(json['captain']),

  ) ;
  factory OrderTrackingModel.fake()=>OrderTrackingModel(
    id: FakeData.fakeInt,
    status: TrackStatus.processing,
    createdAt: FakeData.fakeDateTime,
    captain: const UserModel(
      fullName: "UNKNOW",
      profilePic: FakeData.fakeImg,
      phone: "UNKNOWN",
    ),
  ) ;


  bool get canCancel=>status == TrackStatus.processing || status == TrackStatus.confirmed;
}
