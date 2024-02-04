import 'package:currency_converter_app/core/network/api/currency_api.dart';
import 'package:currency_converter_app/env/env.dart';
import 'package:currency_converter_app/future/currency/data/remote/models/currency_model.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/convert_currency_usecase.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/get_historical_rate_usecase.dart';
import 'package:injectable/injectable.dart';

abstract class CurrencyRemoteDataSource {
  Future<CurrencyModel> getCurrency({
    required String apiKey,
  });
  Future<CurrencyModel> getHistoricalRate({
    required GetHistoricalRateParams params,
  });
  Future<CurrencyModel> convertCurrency({
    required ConvertCurrencyParams params,
  });
}

@LazySingleton(as: CurrencyRemoteDataSource)
class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final CurrencyApi currencyApi;

  CurrencyRemoteDataSourceImpl({required this.currencyApi});

  @override
  Future<CurrencyModel> getCurrency({
    required String apiKey,
  }) async {
    return await currencyApi.getCurrency(
      apiKey: apiKey,
    );
  }

  @override
  Future<CurrencyModel> getHistoricalRate({required GetHistoricalRateParams params}) async {
    return currencyApi.getHistoricalRate(queries: params.toMap());
  }

  @override
  Future<CurrencyModel> convertCurrency({required ConvertCurrencyParams params}) async {
    return currencyApi.convertCurrency(
      currencies: params.currencies,
      apiKey: Env.key,
    );
  }
}
