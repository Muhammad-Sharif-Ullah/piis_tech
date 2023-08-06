import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:piis_tech/core/api/api_endpoint.dart';
import 'package:piis_tech/core/api/api_provider.dart';
import 'package:piis_tech/core/utility/app_extension.dart';

class LeaveListRepository {
  static LeaveListRepository? _instance;
  // Avoid self instance
  LeaveListRepository._();
  static LeaveListRepository get instance {
    _instance ??= LeaveListRepository._();
    return _instance!;
  }

  Future<Either<String, dynamic>> getEmployeeList(
      String userToken, String userId) async {
    log(ApiEndPoints.mgmtModule.getLeaveList);
    return await AppApiProvider.instance
        .get(APIRequestParam(
            path: ApiEndPoints.mgmtModule.getLeaveList,
            options: Options(headers: {
              "Authorization": "Bearer $userToken",
              "userid": userId
            })))
        .then((response) => response.fold(
                (error) => Left(error.message ?? error.dioError()), (success) {
              log(
                "LeaveListRepository Success",
                sequenceNumber: 1,
                level: 0,
                name: "LeaveListRepository.getEmployeeList",
                zone: Zone.current,
                error: "Success : ${success.data.toString()}",
              );
              final data = success.data;
              if (data['success']) {
                try {
                  var employees = data['result'];
                  return Right(employees);
                } catch (e) {
                  log(e.toString());
                  return const Right(null);
                }
              } else {
                return const Right(null);
              }
            }));
  }
}
