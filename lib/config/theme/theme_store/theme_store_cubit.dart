import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:piis_tech/config/theme/app_theme.dart';

part 'theme_store_state.dart';

class ThemeStoreCubit extends HydratedCubit<ThemeState> {
  ThemeStoreCubit() : super(ThemeState(_buildDarkTheme(), AppThemeMode.dark));

  static ThemeData _buildLightTheme() {
    return AppTheme.instance.lightTheme();
  }

  static ThemeData _buildDarkTheme() {
    return AppTheme.instance.darkTheme();
  }

  void toggleTheme() {
    final newTheme = state.appTheme == AppThemeMode.light
        ? AppThemeMode.dark
        : AppThemeMode.light;
    final themeData =
        newTheme == AppThemeMode.light ? _buildLightTheme() : _buildDarkTheme();
    emit(ThemeState(themeData, newTheme));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState(
      json['themeData'] == 'light' ? _buildLightTheme() : _buildDarkTheme(),
      json['appTheme'] == 'light' ? AppThemeMode.light : AppThemeMode.dark,
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {
      'themeData': state.appTheme == AppThemeMode.light ? 'light' : 'dark',
      'appTheme': state.appTheme == AppThemeMode.light ? 'light' : 'dark',
    };
  }
}
