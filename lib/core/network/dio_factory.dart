import 'package:currency_converter_app/core/service/end_point.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DioFactory {
  DioFactory();

  @lazySingleton
  Dio getDio() {
    final client = Dio();

    client.options
      ..baseUrl = EndPoint.baseUrl
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(milliseconds: 30000)
      ..responseType = ResponseType.plain
      ..headers = {
        "App-Language": "en",
        // add bearer token here
      }
      //
      ..followRedirects = false
      ..headers = {'Content-Type': 'application/json'};
    client.interceptors.addAll([]);
    return client;
  }
}
