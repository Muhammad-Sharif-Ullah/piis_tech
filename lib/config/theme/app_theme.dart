import 'package:flutter/material.dart';

class AppTheme {
  static AppTheme? _instance;
  // Avoid self instance
  AppTheme._();
  static AppTheme get instance {
    _instance ??= AppTheme._();
    return _instance!;
  }

  ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      primaryColor: const Color(0xFFDC2129),
      useMaterial3: true,
    );
  }

  ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: const Color(0xFFDC2129),
      useMaterial3: true,
    );
  }
}
