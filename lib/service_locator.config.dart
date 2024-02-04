// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:currency_converter_app/core/network/api/currency_api.dart'
    as _i5;
import 'package:currency_converter_app/core/network/dio_factory.dart' as _i14;
import 'package:currency_converter_app/future/currency/data/local/data_sources/currency_data_local_source.dart'
    as _i3;
import 'package:currency_converter_app/future/currency/data/remote/data_sources/currency_data_source.dart'
    as _i6;
import 'package:currency_converter_app/future/currency/data/repositories/currency_repository_impl.dart'
    as _i8;
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart'
    as _i7;
import 'package:currency_converter_app/future/currency/domain/use_cases/convert_currency_usecase.dart'
    as _i13;
import 'package:currency_converter_app/future/currency/domain/use_cases/get_currency_locally_usecase.dart'
    as _i9;
import 'package:currency_converter_app/future/currency/domain/use_cases/get_currency_usecase.dart'
    as _i10;
import 'package:currency_converter_app/future/currency/domain/use_cases/get_historical_rate_usecase.dart'
    as _i11;
import 'package:currency_converter_app/future/currency/domain/use_cases/save_currency_locally_usecase.dart'
    as _i12;
import 'package:currency_converter_app/service_locator.dart' as _i15;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioFactory = _$DioFactory();
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.CurrencyLocalDataSource>(
        () => _i3.CurrencyLocalDataSourceImpl());
    gh.lazySingleton<_i4.Dio>(() => dioFactory.getDio());
    gh.lazySingleton<_i4.LogInterceptor>(
        () => registerModule.getLogInterceptor());
    gh.factory<_i5.CurrencyApi>(() => _i5.CurrencyApi(gh<_i4.Dio>()));
    gh.lazySingleton<_i6.CurrencyRemoteDataSource>(() =>
        _i6.CurrencyRemoteDataSourceImpl(currencyApi: gh<_i5.CurrencyApi>()));
    gh.lazySingleton<_i7.CurrencyRepository>(() => _i8.CurrencyRepositoryImpl(
          remoteDataSource: gh<_i6.CurrencyRemoteDataSource>(),
          currencyLocalDataSource: gh<_i3.CurrencyLocalDataSource>(),
        ));
    gh.lazySingleton<_i9.GetCurrencyLocallyUseCase>(
        () => _i9.GetCurrencyLocallyUseCase(gh<_i7.CurrencyRepository>()));
    gh.factory<_i10.GetCurrencyUseCase>(
        () => _i10.GetCurrencyUseCase(gh<_i7.CurrencyRepository>()));
    gh.factory<_i11.GetHistoricalRateUseCase>(
        () => _i11.GetHistoricalRateUseCase(gh<_i7.CurrencyRepository>()));
    gh.lazySingleton<_i12.SaveCurrencyLocallyUseCase>(
        () => _i12.SaveCurrencyLocallyUseCase(gh<_i7.CurrencyRepository>()));
    gh.factory<_i13.ConvertCurrencyUseCase>(
        () => _i13.ConvertCurrencyUseCase(gh<_i7.CurrencyRepository>()));
    return this;
  }
}

class _$DioFactory extends _i14.DioFactory {}

class _$RegisterModule extends _i15.RegisterModule {}
