import 'package:currency_converter_app/core/service/end_point.dart';
import 'package:currency_converter_app/future/currency/data/remote/models/currency_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'currency_api.g.dart';

@injectable
@RestApi(
  parser: Parser.FlutterCompute,
)
abstract class CurrencyApi {
  @factoryMethod
  factory CurrencyApi(
    Dio dio,
  ) = _CurrencyApi;

  @GET(EndPoint.getCurrency)
  Future<CurrencyModel> getCurrency({
    @Query('apikey') required String apiKey,
  });
  @GET(EndPoint.historicalRate)
  Future<CurrencyModel> getHistoricalRate({
    @Queries() required Map<String, dynamic> queries,
  });
  @GET(EndPoint.convertCurrency)
  Future<CurrencyModel> convertCurrency({
    @Query('apikey') required String apiKey,
    @Query('currencies') required String currencies,
  });
}
