import 'package:currency_converter_app/core/error/failures.dart';
import 'package:currency_converter_app/future/currency/data/local/models/currency_locally_model.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/convert_currency_usecase.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/get_historical_rate_usecase.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyRepository {
  Future<Either<Failures, Map<String, dynamic>>> getCurrency({
    required String apiKey,
  });
  Future<Either<Failures, bool>> saveCurrencyLocally({required Map<String, dynamic> currencyMap});
  Future<Either<Failures, CurrencyLocallyModel?>> getCurrencyLocally();

  Future<Either<Failures, Map<String, dynamic>>> getHistoricalRate({
    required GetHistoricalRateParams params,
  });
  Future<Either<Failures, Map<String, dynamic>>> convertCurrency({
    required ConvertCurrencyParams params,
  });
}
