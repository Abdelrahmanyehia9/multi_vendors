import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/utils/app_configs.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'package:multi_vendor/shared/data/repository/user_pref_repository.dart';

class UserPreferencesCubit extends Cubit<UserPreferences> {
  final UserPrefRepository repository;

  UserPreferencesCubit(this.repository) : super(const UserPreferences());

  void init(BuildContext context) {
    final pref = repository.getPref();
    AppConfigs.locale = pref.locale ?? context.locale;
    safeEmit(
      pref.copyWith(
        locale: AppConfigs.locale,
      ),
    );
  }

  void setThemeMode(ThemeMode mode) {
    final pref = state.copyWith(themeMode: mode);
    safeEmit(pref);
    repository.updatePref(pref);
  }

  Future<void> changeLocale(
      Locale locale,
      BuildContext context,
      ) async {
    await context.setLocale(locale);
    AppConfigs.locale = locale;
    final pref = state.copyWith(
      locale: locale,
    );
    safeEmit(pref);
    repository.updatePref(pref);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.pushNamedAndRemoveUntil(Routes.splash, predicate: (_) => false);
    });
  }
}