import 'dart:ui';
import 'package:multi_vendor/core/extensions/colors.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import '../../../../../core/enum/banner_type.dart';

class HomeBannerModel {
  final int? id;
  final String? title;
  final String? description;
  final String image;
  final BannerType bannerType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Color? backgroundColor;
  final Color? textColor;
  final String? redirect;
  final String? buttonText;

  const HomeBannerModel({
    this.id,
    this.title,
    this.description,
    required this.image,
    required this.bannerType,
    this.createdAt,
    this.updatedAt,
    this.backgroundColor,
    this.textColor,
    this.redirect,
    this.buttonText,
  });


  factory HomeBannerModel.fromJson(Map<String, dynamic>json)=>
      HomeBannerModel(
          id: json['id'],
          title: json['title'],
          description: json['description'],
          image: json['image'],
          bannerType: BannerType.fromDataBase(json['type']),
         createdAt: json['created_at']==null  ? null : DateTime.parse(json['created_at']),
         updatedAt: json['updated_at']==null  ? null : DateTime.parse(json['updated_at']),
         backgroundColor: ColorExtension.fromRgbString(json['colors']['background_color']),
         textColor: ColorExtension.fromRgbString(json['colors']['text_color']),
         redirect: json['action']['redirect'],
         buttonText: json['action']['title'],
      );
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'image': image,
    'type': bannerType.toDataBase(),
    'created_at': createdAt?.toIso8601String(),
    'updated_at': updatedAt?.toIso8601String(),
    'background_color': backgroundColor?.toRgbString,
    'text_color': textColor?.toRgbString,
    'action': {
      'redirect': redirect,
      'title': buttonText,
    },
  }.withoutNulls;
}
