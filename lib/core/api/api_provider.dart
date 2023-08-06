// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:piis_tech/core/api/api_endpoint.dart';

class APIRequestParam {
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  APIRequestParam({
    required this.path,
    this.data,
    this.queryParameters,
    this.options,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'path': path,
      'data': data,
      'queryParameters': queryParameters,
    };
  }

  factory APIRequestParam.fromMap(Map<String, dynamic> map) {
    return APIRequestParam(
      path: map['path'] as String,
      data: map['data'] as dynamic,
      queryParameters: map['queryParameters'] != null
          ? Map<String, dynamic>.from(
              (map['queryParameters'] as Map<String, dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory APIRequestParam.fromJson(String source) =>
      APIRequestParam.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class ApiProvider {
  Future<Either<DioException, Response>> get(APIRequestParam param);
  Future<Either<DioException, Response>> post(APIRequestParam param);
  Future<Either<DioException, Response>> put(APIRequestParam param);
  Future<Either<DioException, Response>> patch(APIRequestParam param);
  Future<Either<DioException, Response>> delete(APIRequestParam param);
}

class AppApiProvider implements ApiProvider {
  static AppApiProvider? _instance;
  // Avoid self instance
  AppApiProvider._();
  static AppApiProvider get instance {
    _instance ??= AppApiProvider._();
    return _instance!;
  }

  static final Dio dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseURL,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),

    // headers: {
    //   "X-Authorization" : "1y8eGr8r75OOp2D4aMtbsDe6RJbONQL6iIOdH67COieqflQUBu52xTMFgBa6VJdE"
    // }
  ));

  /// Get Api without Token

  // ## Post Api call without token

  @override
  Future<Either<DioException, Response>> delete(APIRequestParam param) async {
    return await Task(() => dio.delete(param.path,
        queryParameters: param.queryParameters,
        options: param.options)).attempt().run().then((either) {
      return either.fold((l) {
        return Left(l as DioException);
      }, (r) {
        return Right(r);
      });
    });
  }

  @override
  Future<Either<DioException, Response>> get(APIRequestParam param) async {
    return await Task(() => dio.get(param.path,
        queryParameters: param.queryParameters,
        options: param.options)).attempt().run().then((either) {
      return either.fold((l) {
        return Left(l as DioException);
      }, (r) {
        return Right(r);
      });
    });
  }

  @override
  Future<Either<DioException, Response>> patch(APIRequestParam param) async {
    return await Task(() => dio.patch(param.path,
        data: param.data,
        queryParameters: param.queryParameters,
        options: param.options)).attempt().run().then((either) {
      return either.fold((l) {
        return Left(l as DioException);
      }, (r) {
        return Right(r);
      });
    });
  }

  @override
  Future<Either<DioException, Response>> post(APIRequestParam param) async {
    return await Task(() => dio.post(param.path,
        data: param.data,
        queryParameters: param.queryParameters,
        options: param.options)).attempt().run().then((either) {
      return either.fold((l) {
        return Left(l as DioException);
      }, (r) {
        return Right(r);
      });
    });
  }

  @override
  Future<Either<DioException, Response>> put(APIRequestParam param) async {
    return await Task(() => dio.put(param.path,
        queryParameters: param.queryParameters,
        options: param.options)).attempt().run().then((either) {
      return either.fold((l) {
        return Left(l as DioException);
      }, (r) {
        return Right(r);
      });
    });
  }

  Options getOption() {
    const String? token = null;
    return Options(headers: {"authorization": "Bearer ${token ?? ""}"});
  }

  // ## Get Api With Token
  // Future<Either<DioException, Response>> getCallWithToken(
  //     {required String url, dynamic params}) async {
  //   var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
  //   logView('AUTH TOKEN : $token');
  //   String data = params ?? "";
  //   return await Task(() => dio.get(
  //         url + data,
  //         options: Options(headers: {"authorization": "Bearer ${token ?? ""}"}),
  //       )).attempt().run().then((either) {
  //     return either.fold((l) {
  //       return Left(l as DioException);
  //     }, (r) {
  //       return Right(r);
  //     });
  //   });
  // }

//# Post Api with Token
  // Future<Either<DioException, Response>> postCallWithToken({
  //   data,
  //   url,
  // }) async {
  //   log('from post request $data');
  //   // log("Post DataMap : ${jsonEncode(data)}");
  //   var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
  //   // //## for Testing
  //   // var urls = Uri.parse("$url");
  //   // var response = await http
  //   //     .post(urls, body: data, headers: {"authorization": "Bearer $token"});
  //   // print('------------Response-------------');
  //   // print(response.body);
  //   return await Task(() => dio.post(url,
  //           data: data,
  //           options: Options(headers: {"authorization": "Bearer $token"})))
  //       .attempt()
  //       .run()
  //       .then((either) {
  //     return either.fold((l) {
  //       return Left(l as DioException);
  //     }, (r) {
  //       return Right(r);
  //     });
  //   });
  // }

  //# Patch Api with Token
  // Future<Either<DioException, Response>> patchCallWithToken({
  //   data,
  //   url,
  // }) async {
  //   log(data.toString());
  //   var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
  //   return await Task(() => dio.patch(url,
  //       data: data,
  //       options: Options(headers: {
  //         "authorization": "Bearer $token",
  //       }))).attempt().run().then((either) {
  //     return either.fold((l) {
  //       final e = l as DioException;
  //       return Left(e);
  //     }, (r) {
  //       return Right(r);
  //     });
  //   });
  // }

  //# Post Api with Token
  // Future<Either<DioException, Response>> postCallWithTokenMultiPath({
  //   data,
  //   url,
  // }) async {
  //   log(data.toString());
  //   var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
  //   logView(token.toString());

  //   return await Task(() => dio.post(url,
  //       data: data,
  //       options: Options(headers: {
  //         "authorization": "Bearer $token",
  //         'Content-Type': 'multipart/formData'
  //       }))).attempt().run().then((either) {
  //     return either.fold((l) {
  //       return Left(l as DioException);
  //     }, (r) {
  //       return Right(r);
  //     });
  //   });

  //   // return await Task(() => dio.post(url,
  //   //     data: data,
  //   //     options: Options(headers: {
  //   //       "authorization": "Bearer $token",
  //   //       'Content-Type': 'multipart/formData'
  //   //     }))).attempt().run().then((either) {
  //   //   logError(either.toString());
  //   //   return either.fold((l) {
  //   //     return Left(l as DioException);
  //   //   }, (r) {
  //   //     return Right(r);
  //   //   });
  //   // });
  // }

//   Future<Map<String, dynamic>> productApiCall({url, formData}) async {
//     List dataMap = [];
//     log('--------APi Calling----');
//     log(url);
//     logView(formData.toString());
//     String? errorMessage = '';
//     await ApiProvider()
//         .postCallWithOutToken(url: url, data: formData)
//         .then((Either<DioException, Response> response) {
//       response.fold((l) {
//         logError(
//             "productApiCall [${l.response?.statusCode}] -> [${l.response?.data}]");

//         final type = NetworkExceptions.getDioException(l);
//         final message = NetworkExceptions.getErrorMessage(type);
//         errorMessage = message;
//       }, (r) {
//         logView('// Product List ${r.data.toString()}');
//         dataMap = r.data as List;
//       });
//     });
//     return {'message': errorMessage, "dataMap": dataMap};
//   }

//   Future<Map<String, dynamic>> customProductApiCall({url, formData}) async {
//     List dataMap = [];
//     log('--------APi Calling----');
//     log(url);
//     logView(formData.toString());
//     String? errorMessage = '';
//     await ApiProvider()
//         .postCallWithOutToken(url: url, data: formData)
//         .then((Either<DioException, Response> response) {
//       response.fold((l) {
//         logError(
//             "customProductApiCall [${l.response?.statusCode}] -> [${l.response?.data}]");

//         final type = NetworkExceptions.getDioException(l);
//         final message = NetworkExceptions.getErrorMessage(type);
//         errorMessage = message;
//       }, (r) {
//         logView('// Product List ${r.data.toString()}');
//         dataMap = r.data['docs'] as List;
//       });
//     });
//     return {'message': errorMessage, "dataMap": dataMap};
//   }

//   Future<Map<String, dynamic>> productApiCallReturnMap({url, formData}) async {
//     List dataMap = [];
//     log('--------APi Calling----');
//     log(url);
//     logView(formData.toString());
//     String? errorMessage = '';
//     await ApiProvider()
//         .postCallWithOutToken(url: url, data: formData)
//         .then((Either<DioException, Response> response) {
//       response.fold((l) {
//         logError(
//             "productApiCallReturnMap [${l.response?.statusCode}] -> [${l.response?.data}]");

//         final type = NetworkExceptions.getDioException(l);
//         final message = NetworkExceptions.getErrorMessage(type);
//         errorMessage = message;
//       }, (r) {
//         logView('// Product List ${r.data.toString()}');
//         dataMap = r.data['docs'] as List;
//       });
//     });
//     return {'message': errorMessage, "dataMap": dataMap};
//   }

//   //## Count items
//   Future<Map<String, dynamic>> countApiCall({
//     url,
//   }) async {
//     Map<String, dynamic> dataMap = {};
//     log('--------APi Calling----');
//     log(url);
//     String? errorMessage = '';
//     await ApiProvider()
//         .getCallWithToken(
//       url: url,
//     )
//         .then((Either<DioException, Response> response) {
//       response.fold((l) {
//         logError(
//             "Failed TO FETCHED Help Count api call ! [${l.response?.statusCode}] -> [[${l.type.toString()}]]");
//         final type = NetworkExceptions.getDioException(l);
//         final message = NetworkExceptions.getErrorMessage(type);
//         errorMessage = message;
//       }, (r) {
//         dataMap = r.data as Map<String, dynamic>;
//         log('// Counted List');
//         log(r.data.toString());
//       });
//     });
//     return {'message': errorMessage, "dataMap": dataMap};
//   }

// //# Post Api with Token
//   Future<Either<DioException, Response>> deletedCallWithToken({
//     data,
//     url,
//   }) async {
//     log(data.toString());
//     var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);
//     // //## for Testing
//     // var urls = Uri.parse("$url");
//     // var response = await http
//     //     .post(urls, body: data, headers: {"authorization": "Bearer $token"});
//     // print('------------Response-------------');
//     // print(response.body);
//     return await Task(() => dio.delete(url,
//             data: data,
//             options: Options(headers: {"authorization": "Bearer $token"})))
//         .attempt()
//         .run()
//         .then((either) {
//       return either.fold((l) {
//         return Left(l as DioException);
//       }, (r) {
//         return Right(r);
//       });
//     });
//   }

//   Future<Map<String, dynamic>> brandApiCall(
//       {required url, required formData}) async {
//     print('00000000000000000000000000000');
//     print(url);
//     print(formData.toString());
//     print(formData);
//     List dataMap = [];
//     String? errorMessage = '';
//     await ApiProvider()
//         .postCallWithOutToken(url: url, data: formData)
//         .then((Either<DioException, Response> response) {
//       response.fold((l) {
//         logError(
//             "Brand API Call [${l.response?.statusCode}] -> [${l.response?.data}]");

//         final type = NetworkExceptions.getDioException(l);
//         final message = NetworkExceptions.getErrorMessage(type);
//         errorMessage = message;
//       }, (r) {
//         dataMap = r.data;
//         log('# Popular Product List');
//         logError(dataMap.toString());
//       });
//     });
//     return {'message': errorMessage, "dataMap": dataMap};
//   }

//   // ## Get Api With Token
//   Future<Either<DioException, Response>> deleteCallWithToken(
//       {required String url, dynamic params}) async {
//     var token = await SecureStorageService().readValue(key: AUTH_TOKEN_KEY);

//     return await Task(() => dio.delete(
//           url,
//           data: params,
//           options: Options(headers: {"authorization": "Bearer ${token ?? ""}"}),
//         )).attempt().run().then((either) {
//       return either.fold((l) {
//         return Left(l as DioException);
//       }, (r) {
//         return Right(r);
//       });
//     });
//   }
}
