import 'package:currency_converter_app/core/error/error_handler.dart';
import 'package:currency_converter_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<Either<Failures, T>> executeAndCatchError<T>(Future<T> Function() function) async {
  try {
    final result = await function();
    return Right(result);
  } on DioException catch (e) {
    return Left(ErrorHandler.handleError(e));
  }
}
