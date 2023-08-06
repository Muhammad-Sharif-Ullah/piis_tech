// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:piis_tech/config/config.dart';

class ApiEndPoints {
  // Avoid self instance
  ApiEndPoints._();
  // static ApiEndPoints get instance {
  //   _instance ??= ApiEndPoints._();
  //   return _instance!;

  // }

  static const String baseURL = AppConfiguration.isDebugApp
      ? "https://sales-api.made-in-bd.net/api/v1/"
      : "https://sales-api.made-in-bd.net/api/v1/";

  static const imageUrl =
      "https://bdesh-s3-bucket.s3.ap-southeast-1.amazonaws.com/";
  static final AuthModule auth = AuthModule();
  static final MgmtModule mgmtModule = MgmtModule();
}

class AuthModule {
  static const String _baseURL = ApiEndPoints.baseURL;
  final String login = p.join(_baseURL, "login");
}

class MgmtModule {
  static const String _baseURL = ApiEndPoints.baseURL;
  final String getEmployeeList = p.join(_baseURL, "get-employee-list");
  final String getActiveEmployeeList =
      p.join(_baseURL, "get-active-employee-list");
  final String getEmployeeAttendance =
      p.join(_baseURL, "get-employee-attendance");
  final String getEmployeeByGuid = p.join(_baseURL, "get-employee-by-guid");
  final String getDataLookupByDataKey =
      p.join(_baseURL, "get-data-lookup-by-data-key");
  final String saveAttendance = p.join(_baseURL, "save-attendance");
  final String uploadImage = p.join(_baseURL, "upload-image");
  final String getLeaveList = p.join(_baseURL, "get-leave-list");
  final String saveLeave = p.join(_baseURL, "save-leave");
}
