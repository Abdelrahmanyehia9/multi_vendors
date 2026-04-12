import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String? img;
  final int? count;
  final String name;
  final String? description;
  final CategoryModel? parent;

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
    parent: json['parent'] != null ? CategoryModel.fromJson(json['parent']) : null,
  );


  factory CategoryModel.fake()=>const CategoryModel(
    name: "Category",
  ) ;

  @override
  List<Object?> get props => [id];
}
