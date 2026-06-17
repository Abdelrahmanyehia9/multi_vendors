// user_preferences_builder.dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_vendor/shared/data/models/user_model.dart';
import 'package:multi_vendor/shared/logic/user_preferences_cubit.dart';

class UserPreferencesBuilder extends StatelessWidget {
  final Widget Function(ThemeMode themeMode, Locale locale) builder;
  const UserPreferencesBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPreferencesCubit, UserPreferences>(
      builder: (context, state) => builder(
        state.darkTheme ==true ? ThemeMode.dark : ThemeMode.light,
        state.locale??context.locale,
      ),
    );
  }
}