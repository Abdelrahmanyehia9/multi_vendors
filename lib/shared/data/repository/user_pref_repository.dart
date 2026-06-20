import 'package:multi_vendor/core/DI/setup_get_it.dart';
import 'package:multi_vendor/core/database/local_storage.dart';
import 'package:multi_vendor/core/database/local_storage_constants.dart';
import 'package:multi_vendor/core/extensions/theme_mode.dart';
import 'package:multi_vendor/core/service/database_service.dart';
import 'package:multi_vendor/core/utils/remote_database_constants.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserPrefRepository {
  final DatabaseService _databaseService;
  final LocalStorage localStorage;

  UserPrefRepository({
    required DatabaseService databaseService,
    required this.localStorage,
  }) : _databaseService = databaseService;

  UserPreferences getPref() {
    final String? themeModeStr = localStorage.read(LocalStorageConstants.theme);
    final String? locale = localStorage.read(LocalStorageConstants.locale);
    return UserPreferences(
      themeMode: ThemeModeExt.fromString(themeModeStr),
      locale: locale == null ? null : Locale(locale),
    );
  }


  Future<void> updatePref(UserPreferences pref) async {
    _saveLocally(pref: pref);
    _updateRemote(pref);
  }

  Future<void> _updateRemote(UserPreferences pref) async {
    final String? uId = userCubit.user?.id;
    if (uId == null) return;
    try {
      await _databaseService.UPDATE(
        id: uId,
        table: RemoteDatabaseConstants.profile_table,
        data: {"preferences": pref.toJson()},
      );
    } catch (_) {}
  }

  Future<void> _saveLocally({required UserPreferences pref}) async {
    await Future.wait([
      localStorage.write(LocalStorageConstants.theme, pref.themeMode.toJson()),
      localStorage.write(LocalStorageConstants.locale, pref.locale?.languageCode),
    ]);
  }
}