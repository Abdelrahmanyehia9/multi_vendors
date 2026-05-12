// user_preferences_states.dart
import 'dart:ui';

class UserPreferencesStates {
  final bool isDark;
  final Locale? locale;

  const UserPreferencesStates({
    this.isDark = false,
    this.locale,
  });

  UserPreferencesStates copyWith({
    bool? isDark,
    Locale? locale,
  }) {
    return UserPreferencesStates(
      isDark: isDark ?? this.isDark,
      locale: locale ?? this.locale,
    );
  }
}