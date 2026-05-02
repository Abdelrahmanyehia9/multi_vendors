import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

import 'package:multi_vendor/features/main/favorite/data/model/favorite_item.dart';

class VendorModel extends Equatable implements FavoriteItem{
  final int? id;
  final String name;
  final String image ;
  final int? count ;
  final bool isVerified;

  const VendorModel({required this.id,this.isVerified = false ,this.count ,required this.name, required this.image});
  factory VendorModel.fromJson(Map<String ,dynamic>json)=>VendorModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      count: json['count'],
      isVerified: json['is_verified']??false,
  );

  factory VendorModel.fake()=> const VendorModel(
    id: FakeData.fakeInt,
    name: "Vendor",
    image: FakeData.fakeImg,
    count: FakeData.fakeInt,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "count": count,
    "is_verified": isVerified,
  }.withoutNulls;
  @override
  // TODO: implement props
  List<Object?> get props => [id];

  @override
  int get favoriteId => id!;
  @override
  String get favoriteName => name;
  @override
  FavoriteType get favoriteType => FavoriteType.vendor;


}