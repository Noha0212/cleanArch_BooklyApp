import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServiceFailure extends Failure {
  ServiceFailure(super.errMessage);
  factory ServiceFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServiceFailure('Connection Timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServiceFailure('Send Timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ServiceFailure('Receive Timeout with API server');
      case DioExceptionType.badCertificate:
        return ServiceFailure('Bad Certificate');
      case DioExceptionType.badResponse:
        return ServiceFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServiceFailure('Request to server was cancelled');
      case DioExceptionType.connectionError:
        return ServiceFailure('No Internet Connection');
      case DioExceptionType.unknown:
        return ServiceFailure('Opps Somthing Went Wrong!');
      default:
        return ServiceFailure('Opps Somthing Went Wrong!');
    }
  }
  factory ServiceFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServiceFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServiceFailure('Your request not found');
    } else if (statusCode == 500) {
      return ServiceFailure('Internal server error, Try again later!');
    } else {
      return ServiceFailure('Opps Somthing Went Wrong!');
    }
  }
}
