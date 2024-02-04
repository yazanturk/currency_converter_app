// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:currency_converter_app/core/network/api/currency_api.dart';
import 'package:currency_converter_app/core/service/end_point.dart';
import 'package:currency_converter_app/env/env.dart';
import 'package:currency_converter_app/future/currency/data/local/data_sources/currency_data_local_source.dart';
import 'package:currency_converter_app/future/currency/data/remote/data_sources/currency_data_source.dart';
import 'package:currency_converter_app/future/currency/data/remote/models/currency_model.dart';
import 'package:currency_converter_app/future/currency/data/repositories/currency_repository_impl.dart';
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/convert_currency_usecase.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/get_currency_usecase.dart';
import 'package:currency_converter_app/main.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CurrencyApi currencyApi;
  late Dio mockDio;
  late CurrencyRepository currencyRepository;
  late GetCurrencyUseCase getCurrencyUseCase;
  late CurrencyRemoteDataSource remoteDataSource;
  late CurrencyLocalDataSource currencyLocalDataSource;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await openHiveForUnitTest();
    mockDio = Dio()
      ..options = BaseOptions(
        baseUrl: EndPoint.baseUrl,
        headers: {
          'Content-Type': 'application/json',
        },
      );

    currencyApi = CurrencyApi(mockDio);
    remoteDataSource = CurrencyRemoteDataSourceImpl(currencyApi: currencyApi);
    currencyLocalDataSource = CurrencyLocalDataSourceImpl();
    currencyRepository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource, currencyLocalDataSource: currencyLocalDataSource);

    getCurrencyUseCase = GetCurrencyUseCase(currencyRepository);
  });
  test('get Currency should return currency without any exception', () async {
    // arrange
    final result = await remoteDataSource.getCurrency(apiKey: Env.key);

    expect(result, isA<CurrencyModel>());

    // act
  });
  // act
  test('exception when getCurrency when apiKey expired or invalid', () async {
    // arrange
    final result = await getCurrencyUseCase(
      'invalid key',
    );

    // assert
    expect(result, isA<Left>());
  });

  test('CONVERT CURRENCY', () async {
    final result = await currencyRepository.convertCurrency(
      params: ConvertCurrencyParams(
        currencies: 'USD,PHP',
      ),
    );

    expect(result, isA<Right>());
  });
  test('CONVERT CURRENCY With Exception Invalid Format', () async {
    final result = await currencyRepository.convertCurrency(
      params: ConvertCurrencyParams(
        currencies: 'USD-PHP',
      ),
    );

    expect(result, isA<Left>());
  });
}
