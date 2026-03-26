import 'package:equatable/equatable.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
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
  final bool? isMale;
  final DateTime? birthDate;
  final String? address;

  const BaseUserModel({
     this.id,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.profilePic,
    this.fcmToken,
    this.isMale,
    this.birthDate,
    this.address,
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
    bool? isMale,
    DateTime? birthDate,
    String? address,
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
      isMale: isMale ?? this.isMale,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
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
      isMale: json['is_male'] as bool?,
      birthDate: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date'])
          : null,
      address: json['address'],
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      fcmToken: json['fcm'],
      isActive: json['is_active'] ?? true,
      country: json['country'] != null
          ? (json['country'] as String).toCountry
          : null,
      role: UserRole.fromQuery(json['role']),
      email: json['email'],
      phone: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_pic': profilePic,
      'fcm': fcmToken,
      'is_active': isActive,
      'country': country?.code,
      'role': role.name,
      'email': email,
      'is_male': isMale,
      'birth_date': birthDate?.toIso8601String(),
      'address': address,
      'phone_number': phone,
    }.withoutNulls();
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
    isMale,
    birthDate,
    address,
    phone,
  ];
}
