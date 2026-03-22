import 'package:equatable/equatable.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import '../enum/user_roles.dart';

class BaseUserModel extends Equatable {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? fullName;
  final String? profilePic;
  final String? fcmToken;
  final bool isActive;
  final Country? country;
  final UserRole role;
  final String? email;
  final String? phone;

  const BaseUserModel({
     this.id,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.profilePic,
    this.fcmToken,
    this.isActive = true,
    this.country,
    this.role = UserRole.customer,
    this.email,
    this.phone,
  });

  BaseUserModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fullName,
    String? profilePic,
    String? fcmToken,
    bool? isActive,
    Country? country,
    UserRole? role,
    String? email,
    String? phone,
  }) {
    return BaseUserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fullName: fullName ?? this.fullName,
      profilePic: profilePic ?? this.profilePic,
      fcmToken: fcmToken ?? this.fcmToken,
      isActive: isActive ?? this.isActive,
      country: country ?? this.country,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  factory BaseUserModel.fromJson(Map<String, dynamic> json) {
    return BaseUserModel(
      id: json['id'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      fcmToken: json['fcm_token'],
      isActive: json['is_active'] ?? true,
      country: json['country'] != null
          ? (json['country'] as String).toCountry
          : null,
      role: UserRole.fromQuery(json['role']),
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'fcm_token': fcmToken,
      'is_active': isActive,
      'country': country?.code,
      'role': role.name,
      'email': email,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [
    id,
    createdAt,
    updatedAt,
    fullName,
    profilePic,
    fcmToken,
    isActive,
    country,
    role,
    email,
    phone,
  ];
}
