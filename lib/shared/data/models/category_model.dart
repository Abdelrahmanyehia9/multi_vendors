import 'package:equatable/equatable.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String? img;
  final int? count;
  final String name;
  final String? description;
  final int? parent;

  const CategoryModel({
    this.id,
    this.img,
    required this.name,
    this.count,
    this.description,
    this.parent,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    img: json['image'],
    name: json['name'],
    count: json['count'],
    description: json['description'],
    parent: json['parent'] ,
  );




  factory CategoryModel.fake()=>const CategoryModel(
    name: "Unknown",
    id: FakeData.fakeInt,
    img: FakeData.fakeImg,
    count: FakeData.fakeInt,
    description: FakeData.fakeStringDesc,
    parent: FakeData.fakeInt,
  ) ;


  Map<String, dynamic> toJson() => {
    "id": id,
    "image": img,
    "name": name,
    "count": count,
    "description": description,
    "parent": parent,
  };


  @override
  List<Object?> get props => [id];
}