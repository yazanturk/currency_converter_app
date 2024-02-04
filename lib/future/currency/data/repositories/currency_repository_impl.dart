import 'package:currency_converter_app/core/error/failures.dart';
import 'package:currency_converter_app/core/network/execute_and_catch_error.dart';
import 'package:currency_converter_app/future/currency/data/local/data_sources/currency_data_local_source.dart';
import 'package:currency_converter_app/future/currency/data/local/models/currency_locally_model.dart';
import 'package:currency_converter_app/future/currency/data/remote/data_sources/currency_data_source.dart';
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/convert_currency_usecase.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/get_historical_rate_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CurrencyRepository)
class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyRemoteDataSource remoteDataSource;
  final CurrencyLocalDataSource currencyLocalDataSource;

  CurrencyRepositoryImpl({required this.remoteDataSource, required this.currencyLocalDataSource});

  @override
  Future<Either<Failures, Map<String, dynamic>>> getCurrency({required String apiKey}) async {
    return executeAndCatchError(() async {
      final response = await remoteDataSource.getCurrency(apiKey: apiKey);
      return response.data ?? {};
    });
  }

  @override
  Future<Either<Failures, bool>> saveCurrencyLocally({required Map<String, dynamic> currencyMap}) async {
    try {
      currencyLocalDataSource.sendCurrencyToLocalDatabase(currencies: currencyMap);

      return const Right(true);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, CurrencyLocallyModel?>> getCurrencyLocally() async {
    try {
      final currencyLocally = await currencyLocalDataSource.getCurrencyFromLocalDatabase();
      return Right(currencyLocally);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> getHistoricalRate({required GetHistoricalRateParams params}) async {
    return executeAndCatchError(() async {
      final response = await remoteDataSource.getHistoricalRate(params: params);
      return response.data ?? {};
    });
  }

  @override
  Future<Either<Failures, Map<String, dynamic>>> convertCurrency({required ConvertCurrencyParams params}) async {
    return executeAndCatchError(() async {
      final response = await remoteDataSource.convertCurrency(params: params);
      return response.data ?? {};
    });
  }
}
