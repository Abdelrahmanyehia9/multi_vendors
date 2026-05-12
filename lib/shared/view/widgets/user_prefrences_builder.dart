// user_preferences_builder.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/shared/logic/user_preferences_cubit.dart';
import 'package:multi_vendor/shared/logic/user_preferences_states.dart';

class UserPreferencesBuilder extends StatelessWidget {
  final Widget Function(ThemeMode themeMode, Locale locale) builder;
  const UserPreferencesBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreferencesCubit, UserPreferencesStates>(
      builder: (context, state) => builder(
        state.isDark ? ThemeMode.dark : ThemeMode.light,
        state.locale??context.locale,
      ),
    );
  }
}