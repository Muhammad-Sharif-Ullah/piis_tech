part of 'theme_store_cubit.dart';

enum AppThemeMode { light, dark, system }

class ThemeState {
  final ThemeData themeData;
  final AppThemeMode appTheme;

  ThemeState(this.themeData, this.appTheme);
}
