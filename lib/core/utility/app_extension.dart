import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:piis_tech/config/config.dart';

enum SnackBarActionType { error, warning, success }

extension CustomSnackBar on BuildContext {
  void snack({
    required String title,
    String? subTitle,
    VoidCallback? onDismiss,
    String? dismissLabel,
    Duration? duration,
    SnackBarActionType snackBarActionType = SnackBarActionType.success,
  }) {
    final snackbar = SnackBar(
      duration: duration ?? const Duration(seconds: 1),
      content: Text(
        title,
        style: TextStyle(
            color: snackBarActionType == SnackBarActionType.success
                ? Colors.black
                : snackBarActionType == SnackBarActionType.error
                    ? Colors.white
                    : Colors.black),
      ),
      backgroundColor: snackBarActionType == SnackBarActionType.success
          ? Colors.greenAccent
          : snackBarActionType == SnackBarActionType.error
              ? Colors.redAccent
              : Colors.yellowAccent,
      action: (onDismiss == null && dismissLabel == null)
          ? null
          : SnackBarAction(
              label: dismissLabel ?? "",
              onPressed: onDismiss ?? () {},
            ),
    );
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(snackbar);
  }
}

extension FileBasePath on String {
  getBasePath() {
    File file = File(this);
    return basename(file.path);
  }
}

extension DefaultTextFactor on BuildContext {
  appTextFactor() {
    return MediaQuery.of(this)
        .textScaleFactor
        .clamp(AppConfiguration.lowerFactor, AppConfiguration.higherFactor);
  }
}

extension NumericStringExtension on String {
  bool get isNumeric {
    final numeric = double.tryParse(this);
    return numeric != null;
  }

  List<String> splitTime(String pattern) {
    return this.split(pattern).where((element) => element.isNumeric).toList();
  }
}

extension ConvertTime on List {
  String toTime() {
    switch (length) {
      case 3:
        return "${this[0]} D ${this[1]} hrs ${this[2]} min";

      case 2:
        return "${this[0]} hrs ${this[1]} min";
      default:
        return "${this[0]} min";
    }
  }

  String toFilterTime() {
    switch (where((element) => element != 0).toList().length) {
      case 3:
        return "${this[0]} D ${this[1]} hrs ${this[2]} min";

      case 2:
        return "${this[0]} hrs ${this[1]} min";
      default:
        return "${this[0]} min";
    }
  }
}

// extension StringToDouble on String {
//   double asNumericalValue() {
//     return double.tryParse(replaceAll(RegExp('[^0-9.]'), '')) ?? 0;
//   }
// }

extension StringToDouble on String {
  double stringToDouble() {
    final numericRegex = RegExp(r'[^0-9\.]+');
    final cleanString = replaceAll(numericRegex, '');
    return double.parse(cleanString);
  }
}
// extension StringExtensions on String {
//   double toDoubleOrNull() {
//     final str = trim();
//     if (str.isEmpty) {
//       return 0.0;
//     }
//     final number = double.tryParse(str);
//     return number ?? 0;
//   }
// }

extension SUtil on BuildContext {
  TextStyle get h1 => Theme.of(this).textTheme.displayLarge!;
  TextStyle get h2 => Theme.of(this).textTheme.displayMedium!;
  TextStyle get h3 => Theme.of(this).textTheme.displaySmall!;
  TextStyle get h4 => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get h5 => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get h6 => Theme.of(this).textTheme.titleLarge!;
  TextStyle get caption => Theme.of(this).textTheme.bodySmall!;
  TextStyle get bodyText1 => Theme.of(this).textTheme.bodyLarge!;
  TextStyle get bodyText2 => Theme.of(this).textTheme.bodyMedium!;
  TextStyle? get body => Theme.of(this).textTheme.bodyLarge;
  TextStyle get button => Theme.of(this).textTheme.labelLarge!;
  // ButtonTheme get buttonTheme => Theme.of(this).buttonBarTheme.buto,
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  AppBarTheme get appBarTheme => Theme.of(this).appBarTheme;
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  ElevatedButtonThemeData get elevatedTheme =>
      Theme.of(this).elevatedButtonTheme;
  // bool get isDarkMode {
  //   var brightness = MediaQuery.of(context).platformBrightness;
  //   return brightness == Brightness.dark;
  // }
}

extension DioErrorAsString on DioException {
  String dioError() {
    switch (type) {
      case DioExceptionType.cancel:
        return "We're sorry, but there seems to be a delay in connecting to the server. Please check your internet connection and try again. If the problem persists, please contact our support team for further assistance. We apologize for any inconvenience caused";
      case DioExceptionType.connectionTimeout:
        return "We're sorry, but there seems to be a delay in connecting to the server. Please check your internet connection and try again. If the problem persists, please contact our support team for further assistance. We apologize for any inconvenience caused";
      case DioExceptionType.unknown:
        return "Slow or no internet connection";
      case DioExceptionType.receiveTimeout:
        return "We're sorry, but there seems to be a delay in connecting to the server. Please check your internet connection and try again. If the problem persists, please contact our support team for further assistance. We apologize for any inconvenience caused";
      case DioExceptionType.badResponse:
        switch (response?.statusCode) {
          case 400:
            return "Bad request";
          case 401:
            return "Unauthorized access";
          case 403:
            return "Forbidden access";
          case 404:
            return "Resource not found";
          case 409:
            return "Conflict";
          case 500:
            return "Internal server error";
          default:
            return "An error occurred. Please try again";
        }
      case DioExceptionType.sendTimeout:
        return "We're sorry, but there seems to be a delay in connecting to the server. Please check your internet connection and try again. If the problem persists, please contact our support team for further assistance. We apologize for any inconvenience caused";
      default:
    }
    return "An error occurred. Please try again";
  }

  // String getDioErrorMessage(DioError error) {
  //   String message = '';

  //   if (error.type == DioExceptionType.connectTimeout ||
  //       error.type == DioExceptionType.receiveTimeout ||
  //       error.type == DioExceptionType.sendTimeout) {
  //     message = 'Request timeout';
  //   } else if (error.type == DioExceptionType.response) {
  //     switch (error.response?.statusCode) {
  //       case 400:
  //         message = 'Bad request';
  //         break;
  //       case 401:
  //         message = 'Unauthorized request';
  //         break;
  //       case 403:
  //         message = 'Forbidden';
  //         break;
  //       case 404:
  //         message = 'Resource not found';
  //         break;
  //       case 409:
  //         message = 'Conflict';
  //         break;
  //       case 500:
  //         message = 'Internal server error';
  //         break;
  //       case 503:
  //         message = 'Service unavailable';
  //         break;
  //       default:
  //         message = 'Unknown error';
  //     }
  //   } else if (error.type == DioExceptionType.cancel) {
  //     message = 'Request canceled';
  //   } else {
  //     message = 'Connection failed';
  //   }

  //   return message;
  // }
}
