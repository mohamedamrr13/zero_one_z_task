import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/error_handling/error_handling.dart';

class Api {
  final Dio dio;
  final String baseUrl = 'https://heavenvally.zeroonez.com/api/';
  Api(this.dio);
  Future<Either<ServerFailure, dynamic>> get({required String endPoint}) async {
    try {
      Response response = await dio.get(baseUrl + endPoint);
      if (response.statusCode == 200) {
        return Right(response.data);
      }
      return Left(
        ServerFailure.fromResponse(
          response.statusCode!,
          response.statusMessage,
        ),
      );
    } on DioException catch (e) {
      return Left(ServerFailure.from(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error ${e.toString()}'));
    }
  }

  Future<Either<ServerFailure, dynamic>> post({
    required String endPoint,
    @required dynamic body,
    @required String? token,
  }) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers.addAll({'Authorization': 'Bearer $token'});
    }

    try {
      Response response = await dio.post(
        baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        debugPrint('posting data----------------- ${response.data}');
        return Right(response.data);
      } else {
        return Left(
          ServerFailure.fromResponse(
            response.statusCode!,
            response.statusMessage,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.from(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error ${e.toString()}'));
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
    debugPrint('endPoint = $endPoint body = $body token = $token ');
    try {
      Response response = await dio.put(
        baseUrl + endPoint,
        data: body,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        debugPrint(response.data);
        return Right(response.data);
      } else {
        return Left(
          ServerFailure.fromResponse(
            response.statusCode!,
            response.statusMessage,
          ),
        );
      }
    } on DioException catch (e) {
      return Left(ServerFailure.from(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error ${e.toString()}'));
    }
  }
}
