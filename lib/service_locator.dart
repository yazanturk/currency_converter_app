import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final sl = GetIt.instance;

@InjectableInit()
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
