import 'package:currency_converter_app/core/error/failures.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  static Failures handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    return const DefaultFailure(message: 'Something went wrong');
  }

  static Failures _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return const ServerFailure(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return const ServerFailure(message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return const ServerFailure(message: 'Receive timeout');
      case DioExceptionType.badResponse:
        final response = error.response;
        if (response != null) {
          final statusCode = response.statusCode;
          final message = response.data['message'] as String;
          return _handleResponseCode(statusCode ?? 0, message);
        }
        return const DefaultFailure(message: 'Bad response');
      default:
        return const DefaultFailure(message: 'Something went wrong');
    }
  }
}

_handleResponseCode(int statusCode, String message) {
  switch (statusCode) {
    case ResponseCode.badRequest:
      return BadRequestFailure(message: message);
    case ResponseCode.unauthorized:
      return UnauthorizedFailure(message: message);
    case ResponseCode.forbidden:
      return ForbiddenFailure(message: message);
    case ResponseCode.notFound:
      return NotFoundFailure(message: message);
    case ResponseCode.internalServerError:
      return ServerFailure(message: message);
    default:
      return DefaultFailure(message: message);
  }
}

class ResponseCode {
  // API status codes
  static const int success = 200; // success with data
  static const int noContent = 201; // success with no content
  static const int badRequest = 400; // failure, api rejected the requests
  static const int forbidden = 403; // failure, api rejected the requests
  static const int unauthorized = 401; // failure user is not authorised
  static const int notFound = 404;
  static const int internalServerError = 500;
}
