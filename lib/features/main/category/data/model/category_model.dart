import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String? img;
  final int? count;
  final Map<String, dynamic> name;
  final Map<String, dynamic>? description;
  final int? parent;
final String? icon ;
final Color? color ;
  const CategoryModel({
    this.id,
    this.img,
    required this.name,
    this.count,
    this.description,
    this.parent,
    this.icon,
    this.color
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    img: json['image'],
    name: json['name'],
    count: json['count'],
    description: json['description'],
    parent: json['parent'] ,
    icon: json['icon'],
    color: json['color'] == null ? null : ColorExtension.fromRgbString(json['color']),
  );




  factory CategoryModel.fake()=>const CategoryModel(
    name: FakeData.fakeMapName,
    id: FakeData.fakeInt,
    img: FakeData.fakeImg,
    count: FakeData.fakeInt,
    description: FakeData.fakeMapDescription,
    parent: FakeData.fakeInt,
    icon: FakeData.fakeImg,
  ) ;


  Map<String, dynamic> toJson() => {
    "id": id,
    "image": img,
    "name": name,
    "count": count,
    "description": description,
    "parent": parent,
    "icon": icon,
    "color": color?.toRgbString,
  }.withoutNulls;


  @override
  List<Object?> get props => [id];
}