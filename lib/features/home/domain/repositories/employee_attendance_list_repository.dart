import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:piis_tech/core/api/api_endpoint.dart';
import 'package:piis_tech/core/api/api_provider.dart';
import 'package:piis_tech/core/utility/app_extension.dart';
import 'package:piis_tech/features/home/domain/entities/attendance_entities.dart';

class EmployeeAttendanceListRepository {
  static EmployeeAttendanceListRepository? _instance;
  // Avoid self instance
  EmployeeAttendanceListRepository._();
  static EmployeeAttendanceListRepository get instance {
    _instance ??= EmployeeAttendanceListRepository._();
    return _instance!;
  }

  Future<Either<String, List<AttendanceEntities>>> getEmployeeList(
      String userToken, String employeeId) async {
    return await AppApiProvider.instance
        .get(APIRequestParam(
            path: ApiEndPoints.mgmtModule.getEmployeeAttendance,
            options: Options(headers: {
              "Authorization": "Bearer $userToken",
              "employeeId": employeeId
            })))
        .then((response) => response.fold(
                (error) => Left(error.message ?? error.dioError()), (success) {
              log(
                "EmployeeAttendanceListRepository Success",
                sequenceNumber: 1,
                level: 0,
                name: "EmployeeAttendanceListRepository.getEmployeeList",
                zone: Zone.current,
                error: "Success : ${success.data.toString()}",
              );
              final data = success.data;
              if (data['success']) {
                try {
                  final List<AttendanceEntities> employees =
                      List.from(data['result'])
                          .map((e) => AttendanceEntities.fromMap(e))
                          .toList();
                  return Right(employees);
                } catch (e) {
                  log(e.toString());
                  return const Right([]);
                }
              } else {
                return const Right([]);
              }
            }));
  }
}
