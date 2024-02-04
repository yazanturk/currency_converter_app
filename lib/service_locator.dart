import 'package:currency_converter_app/core/network/api/currency_api.dart';
import 'package:currency_converter_app/future/currency/data/local/data_sources/currency_data_local_source.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/get_currency_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  ignoreUnregisteredTypes: [
    Dio,
    LogInterceptor,
    CurrencyApi,
    GetCurrencyUseCase,
    CurrencyLocalDataSource,
  ], // ignore: argument_type_not_assignable
)
Future<void> configureDependencies() async => sl.init();

@module
abstract class RegisterModule {
  @lazySingleton
  LogInterceptor getLogInterceptor() => LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
        responseHeader: false,
        requestHeader: true,
      );
}
