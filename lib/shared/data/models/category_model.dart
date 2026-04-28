import 'package:equatable/equatable.dart';

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
    name: "Category",
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