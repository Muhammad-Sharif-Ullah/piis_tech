import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:piis_tech/core/api/api_endpoint.dart';
import 'package:piis_tech/core/api/api_provider.dart';
import 'package:piis_tech/core/utility/app_extension.dart';
import 'package:piis_tech/features/home/domain/entities/employee_entities.dart';

class EmployeeListRepository {
  static EmployeeListRepository? _instance;
  // Avoid self instance
  EmployeeListRepository._();
  static EmployeeListRepository get instance {
    _instance ??= EmployeeListRepository._();
    return _instance!;
  }

  Future<Either<String, List<EmployeesEntities>>> getEmployeeList(
      String userToken) async {
    return await AppApiProvider.instance
        .get(APIRequestParam(
            path: ApiEndPoints.mgmtModule.getEmployeeList,
            options: Options(headers: {
              "Authorization": "Bearer $userToken",
            })))
        .then((response) => response.fold(
                (error) => Left(error.message ?? error.dioError()), (success) {
              log(
                "EmployeeListRepository Success",
                sequenceNumber: 1,
                level: 0,
                name: "EmployeeListRepository.getEmployeeList",
                zone: Zone.current,
                error: "Success : ${success.data.toString()}",
              );

              final data = success.data;
              if (data['success']) {
                try {
                  final List<EmployeesEntities> employees =
                      List.from(data['result'])
                          .map((e) => EmployeesEntities.fromMap(e))
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
