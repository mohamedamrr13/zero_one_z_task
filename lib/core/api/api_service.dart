import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/error_handling/error_handling.dart';

class Api {
  final Dio dio;
  final String baseUrl = 'https://heavenvally.zeroonez.com/api/';

  Api(this.dio) {
    _configureDio();
  }

  void _configureDio() {
    dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      validateStatus: (status) {
        return status != null && status < 500;
      },
    );

    // Add interceptor for logging
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
          debugPrint('REQUEST HEADERS: ${options.headers}');
          debugPrint('REQUEST BODY: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            'RESPONSE[${response.statusCode}] => DATA: ${response.data}',
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          debugPrint(
            'ERROR[${error.response?.statusCode}] => MESSAGE: ${error.message}',
          );
          debugPrint('ERROR TYPE: ${error.type}');
          return handler.next(error);
        },
      ),
    );
  }

  Future<Either<ServerFailure, dynamic>> get({required String endPoint}) async {
    try {
      debugPrint('Making GET request to: $baseUrl$endPoint');

      Response response = await dio.get(
        endPoint,
        options: Options(
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint('Response received: ${response.statusCode}');

      if (response.statusCode == 200) {
        return Right(response.data);
      }
      return Left(
        ServerFailure.fromResponse(response.statusCode!, response.data),
      );
    } on DioException catch (e) {
      debugPrint('DioException caught: ${e.type}');
      debugPrint('DioException message: ${e.message}');
      debugPrint('DioException error: ${e.error}');
      return Left(ServerFailure.from(e));
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<ServerFailure, dynamic>> post({
    required String endPoint,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    try {
      debugPrint('Making POST request to: $baseUrl$endPoint');
      debugPrint('POST body: $body');

      Response response = await dio.post(
        endPoint,
        data: body,
        options: Options(
          headers: headers,
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      debugPrint('POST Response: ${response.statusCode}');

      if (response.statusCode == 200) {
        debugPrint('POST response data: ${response.data}');
        return Right(response.data);
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode!, response.data),
        );
      }
    } on DioException catch (e) {
      debugPrint('POST DioException: ${e.type} - ${e.message}');
      debugPrint('POST Response: ${e.response?.data}');
      return Left(ServerFailure.from(e));
    } catch (e) {
      debugPrint('POST Unexpected error: $e');
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }

  Future<Either<ServerFailure, dynamic>> put({
    required String endPoint,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    headers.addAll({'Content-Type': 'application/x-www-form-urlencoded'});
    if (token != null) {
      headers.addAll({"Authorization": "Bearer $token"});
    }

    debugPrint('Making PUT request to: $baseUrl$endPoint');
    debugPrint('PUT body: $body');

    try {
      Response response = await dio.put(
        endPoint,
        data: body,
        options: Options(
          headers: headers,
          followRedirects: true,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('PUT response: ${response.data}');
        return Right(response.data);
      } else {
        return Left(
          ServerFailure.fromResponse(response.statusCode!, response.data),
        );
      }
    } on DioException catch (e) {
      debugPrint('PUT DioException: ${e.type} - ${e.message}');
      return Left(ServerFailure.from(e));
    } catch (e) {
      debugPrint('PUT Unexpected error: $e');
      return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
    }
  }
}
