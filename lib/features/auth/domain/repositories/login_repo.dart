import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:piis_tech/core/api/api_endpoint.dart';
import 'package:piis_tech/core/api/api_provider.dart';
import 'package:piis_tech/core/utility/app_extension.dart';
import 'package:piis_tech/features/auth/domain/entities/login_entities.dart';
import 'package:piis_tech/features/auth/domain/entities/user_entities.dart';

class LoginRepo {
  static LoginRepo? _instance;
  // Avoid self instance
  LoginRepo._();
  static LoginRepo get instance {
    _instance ??= LoginRepo._();
    return _instance!;
  }

  Future<Either<String, UserEntities>> logIn(LoginEntities payload) async {
    return await AppApiProvider.instance
        .post(
      APIRequestParam(
          path: ApiEndPoints.auth.login,
          options: Options(headers: payload.toMap())),
    )
        .then(
      (response) {
        log('=' * 100);
        log(
          "URL : ${ApiEndPoints.auth.login}",
          sequenceNumber: 0,
          level: 0,
          name: "LoginRepo.postCall",
          zone: Zone.current,
          error: "Passing Data : ${payload.toJson()}",
        );
        return response.fold((error) {
          String errorMessage =
              error.response?.data['message'] ?? error.dioError();
          log(
            "Login Failed",
            sequenceNumber: 1,
            level: 0,
            name: "LoginRepo.postCall",
            zone: Zone.current,
            error: "Error : $errorMessage",
          );
          return Left(errorMessage);
        }, (success) {
          final userData = success.data;
          log(
            "Login Success",
            sequenceNumber: 1,
            level: 0,
            name: "LoginRepo.postCall",
            zone: Zone.current,
            error: "UserData : $userData",
          );
          if (userData['success']) {
            try {
              final UserEntities user =
                  UserEntities.fromMap(userData['result']);
              return Right(user);
            } catch (e) {
              return const Left("Could not sign in. Please try again.");
            }
          } else {
            return Left(userData['error']);
          }
        });
      },
    );
  }
}
