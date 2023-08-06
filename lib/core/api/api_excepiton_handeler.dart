import 'package:dio/dio.dart';

class APIExceptionHandler {
  static String handleException(dynamic error) {
    String errorMessage = "An error occurred. Please try again later.";
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        errorMessage = "Connection timed out. Please try again later.";
      } else if (error.type == DioExceptionType.badResponse) {
        if (error.response?.statusCode == 400) {
          errorMessage = "Invalid request. Please try again.";
        } else if (error.response?.statusCode == 401) {
          errorMessage = "Unauthorized. Please login again.";
        } else if (error.response?.statusCode == 403) {
          errorMessage = "Access denied. Please contact support.";
        } else if (error.response?.statusCode == 404) {
          errorMessage = "Resource not found. Please try again later.";
        } else if (error.response?.statusCode == 500) {
          errorMessage =
              "An error occurred on the server. Please try again later.";
        } else {
          errorMessage = "An error occurred. Please try again later.";
        }
      } else if (error.type == DioExceptionType.cancel) {
        errorMessage = "Request cancelled.";
      } else {
        errorMessage = "An error occurred. Please try again later.";
      }
    }
    return errorMessage;
  }
}
