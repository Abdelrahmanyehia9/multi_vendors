import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';

class NewsModel {
  final int? id;
  final String? title;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? thumbnail;
  final List<String>? images;
  final String description;
  const NewsModel({
     this.id,
     this.title,
     this.createdAt,
     this.updatedAt,
     this.thumbnail,
     this.images,
     this.description ="",
  });
  factory NewsModel.fromJson(Map<String, dynamic>json)=>NewsModel(
    id:  json['id'],
    title: json['title'],
    createdAt: json['created_at']!=null ? DateTime.parse(json['created_at']) : null,
    updatedAt: json['updated_at']!=null ? DateTime.parse(json['updated_at']) : null,
    thumbnail: json['thumbnail'],
    images: json['images']!=null ? List<String>.from(json['images']) : null,
    description: json['description'],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "thumbnail": thumbnail,
    "images": images,
    "description": description,
  }.withoutNulls;
  NewsModel copyWith({
    int? id,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? thumbnail,
    List<String>? images,
    String? description,
  }) => NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      thumbnail: thumbnail ?? this.thumbnail,
      images: images ?? this.images,
      description: description ?? this.description,
    );


  factory NewsModel.fake()=>const NewsModel(
    id: FakeData.fakeInt,
    title: FakeData.fakeStringTitle,
    description: FakeData.fakeStringDesc,
    thumbnail: FakeData.fakeImg,
    images: [FakeData.fakeImg],
  );

}
