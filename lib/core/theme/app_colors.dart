import 'dart:ui';

class AppColors {
  static AppColors? _instance;
  // Avoid self instance
  AppColors._();
  static AppColors get instance {
    _instance ??= AppColors._();
    return _instance!;
  }

  // static const green = Color(0xFF45EA69);
  static const green = Color(0xFFDC2129);

  /// new Color : #0DC842 | old : 0xFF45EA69
  static const primaryColor = Color(0xFFDC2129);
  static const darkGreen = Color(0xFF103509);
  static const lightGreen = Color(0xFFDDFFE4);
  static const magenta = Color(0xFF5B0069);
  static const magentaLight = Color(0xFFA222B5);
  static const purpleDark = Color(0xFF361E69);
  static const purple = Color(0xFF582BB5);
  static const gray2 = Color(0xFF50535C);
  static const gray = Color(0xFF51545D);

  static const gray3 = Color(0xFFA5A8AF);
  static const icon1 = Color(0xFF53535D);
  static const icon2 = Color(0xFF8B8994);
  static const icon3 = Color(0xFF52525E);
  static const dark = Color(0xFF202125);
  static const red = Color(0xFFEA2A1D);
  static const cardBgColor = Color(0xff363636);
  static const fastest = Color(0xFFDE2A3F);
  static const cheapest = Color(0xFF1D9706);
  static const yellow = Color(0xFFF7FF9E);
}
