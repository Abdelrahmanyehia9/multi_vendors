
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:multi_vendor/core/extensions/country.dart';
import 'package:multi_vendor/core/extensions/data_type.dart';
import 'package:multi_vendor/core/enum/user_roles.dart';
import 'package:multi_vendor/core/extensions/theme_mode.dart';
import 'package:multi_vendor/core/utils/helper/fake_data.dart';
import 'package:multi_vendor/features/main/profile/data/model/address_model.dart';

class UserModel extends Equatable {
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
  final AddressModel? address;
  final UserPreferences? preferences;

  const UserModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.fullName,
    this.profilePic,
    this.preferences,
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

  UserModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? fullName,
    String? profilePic,
    String? fcmToken,
    bool? isMale,
    DateTime? birthDate,
    AddressModel? address,
    bool? isActive,
    Country? country,
    UserRole? role,
    UserPreferences? preferences,
    String? email,
    String? phone,
  }) {
    return UserModel(
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
      preferences: preferences ?? this.preferences,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      preferences: json['preferences'] ==null ?null :UserPreferences.fromJson(json['preferences']),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      isMale: json['is_male'] as bool?,
      birthDate: json['birth_date'] != null
          ? DateTime.tryParse(json['birth_date'])
          : null,
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'])
          : null,
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
      role: json['role'] == null
          ? UserRole.customer
          : UserRole.fromQuery(json['role']),
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
      'preferences': preferences?.toJson(),
      'birth_date': birthDate?.toIso8601String(),
      'phone_number': phone,
    }.withoutNulls;
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    profilePic,
    country,
    email,
    isMale,
    birthDate,
    phone,
    address,
  ];

  factory UserModel.fake() => const UserModel(
    profilePic: FakeData.fakeImg,
    fullName: FakeData.fakeStringTitle,
  );
}



class UserPreferences {
  final Locale? locale;
  final ThemeMode themeMode;

  const UserPreferences({
    this.locale,
    this.themeMode = ThemeMode.system,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      UserPreferences(
        locale: json['locale'] == null ? null : Locale(json['locale']),
        themeMode: ThemeModeExt.fromString(json['theme_mode']),
      );

  Map<String, dynamic> toJson() => {
    'locale': locale?.languageCode,
    'theme_mode': themeMode.name,
  };

  UserPreferences copyWith({Locale? locale, ThemeMode? themeMode}) =>
      UserPreferences(
        locale: locale ?? this.locale,
        themeMode: themeMode ?? this.themeMode,
      );


}