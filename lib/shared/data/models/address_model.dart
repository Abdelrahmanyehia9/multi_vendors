import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class AddressModel extends Equatable {
  final int? id;
  final DateTime? createdAt;
  final String? name;
  final String country;
  final String city;
  final String buildNum;
  final int? floor;
  final String aptNum;
  final String street;
  final String? specialMark;
  final int? postalCode;

  const AddressModel({
    this.id,
    this.createdAt,
    this.name,
    required this.country,
    required this.city,
    required this.buildNum,
    this.floor,
    required this.aptNum,
    required this.street,
    this.specialMark,
    this.postalCode
  });

  AddressModel copyWith({
    int? id,
    DateTime? createdAt,
    String? locationName,
    String? country,
    String? city,
    String? buildNum,
    int? floor,
    String? aptNum,
    String? street,
    String? specialMark,
    int? postalCode,
  }) =>
      AddressModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: locationName ?? name,
        country: country ?? this.country,
        city: city ?? this.city,
        buildNum: buildNum ?? this.buildNum,
        floor: floor ?? this.floor,
        aptNum: aptNum ?? this.aptNum,
        street: street ?? this.street,
        specialMark: specialMark ?? this.specialMark,
        postalCode: postalCode ?? this.postalCode
      );


  factory AddressModel.fromJson(Map<String, dynamic>json)=>
      AddressModel(
          country: json['country'],
          city: json['city'],
          buildNum: json['build_number'],
          aptNum: json['flat_number'],
          street: json['street'],
        floor: json['floor'],
        createdAt: json['created_at'] == null ? null : DateTime.parse(json['created_at']),
        name: json['name'],
        id: json['id'],
        postalCode: json['postal'],
        specialMark: json['special_mark'],
      );
  factory AddressModel.fake()=>
      AddressModel(
          country: "EGYPT",
          city: "Cairo",
          buildNum: "10",
          aptNum: "323",
          street: FakeData.fakeStringTitle,
        floor: FakeData.fakeInt,
        createdAt: FakeData.fakeDateTime,
        name: FakeData.fakeStringTitle,
        postalCode: 0000000,
        specialMark: "NONE",
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'country': country,
    'city': city,
    'build_number': buildNum,
    'floor': floor,
    'flat_number': aptNum,
    'street': street,
    'postal': postalCode,
    'special_mark': specialMark,
  }.withoutNulls;
  @override
  List<Object?> get props =>
      [
        id,
        name,
        country,
        city,
        buildNum,
        floor,
        aptNum,
        street,
        specialMark,
        postalCode,
      ];
  String get addressDisplay => name?? "$buildNum $street , $city , $country";
}