// user_preferences_cubit.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_vendor/core/database/local_storage.dart';
import 'package:multi_vendor/core/database/local_storage_constants.dart';
import 'package:multi_vendor/core/extensions/navigation.dart';
import 'package:multi_vendor/core/extensions/safe_emit.dart';
import 'package:multi_vendor/core/routes/routes.dart';
import 'package:multi_vendor/core/service/navigation_service.dart';
import 'package:multi_vendor/shared/logic/user_preferences_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPreferencesCubit extends Cubit<UserPreferencesStates> {
  final LocalStorage localStorage;

  UserPreferencesCubit(this.localStorage) : super(const UserPreferencesStates());

  void init() {
    final bool isDark = localStorage.read(LocalStorageConstants.isDark) ?? false;
    final String localeCode = localStorage.read(LocalStorageConstants.locale) ?? 'en';

    safeEmit(state.copyWith(
      isDark: isDark,
      locale: Locale(localeCode),
    ));
  }

  void toggleTheme() {
    safeEmit(state.copyWith(isDark: !state.isDark));
    save();
  }

  void changeLocale(Locale locale, BuildContext context) {
    EasyLocalization.of(context)?.setLocale(locale);
    safeEmit(state.copyWith(locale: locale));
    save();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NavigationService.context?.pushNamedAndRemoveUntil(
        Routes.splash,
        predicate: (route) => false,
      );
    });
  }

  Future<void> save() async {
    await Future.wait([
      localStorage.write(LocalStorageConstants.isDark, state.isDark),
      localStorage.write(LocalStorageConstants.locale, state.locale.languageCode),
    ]);
  }
}