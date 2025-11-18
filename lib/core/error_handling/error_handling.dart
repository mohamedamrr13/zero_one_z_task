import 'package:dio/dio.dart';

class Failure {
  final String message;
  final String? code;

  Failure({required this.message, this.code});

  @override
  String toString() => 'Failure(code: $code, message: $message)';
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.code});

  factory ServerFailure.from(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: 'Connection timeout with Api server');
      case DioExceptionType.sendTimeout:
        return ServerFailure(message: 'Send timeout with Api server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(message: 'Receive timeout with api server');
      case DioExceptionType.badCertificate:
        return ServerFailure(message: 'Bad certificate with api server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode!,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(message: 'Request to api server was canceled');

      case DioExceptionType.connectionError:
        return ServerFailure(message: 'No Internet Connection');
      case DioExceptionType.unknown:
        return ServerFailure(
          message: 'Opps There was an Error, Please try again',
        );
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure(message: 'Your request was not found');
    } else if (statusCode == 500) {
      return ServerFailure(
        message: 'There is a problem with server, please try later',
      );
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['error']['message']);
    } else {
      return ServerFailure(message: 'There was an error,please try again');
    }
  }
}
