import 'package:currency_converter_app/core/service/cache_helper.dart';
import 'package:currency_converter_app/future/currency/data/local/models/currency_locally_model.dart';
import 'package:injectable/injectable.dart';

abstract class CurrencyLocalDataSource {
  Future<CurrencyLocallyModel?> getCurrencyFromLocalDatabase();
  Future<void> sendCurrencyToLocalDatabase({
    required Map<String, dynamic> currencies,
  });
}

@LazySingleton(as: CurrencyLocalDataSource)
class CurrencyLocalDataSourceImpl implements CurrencyLocalDataSource {
  CurrencyLocalDataSourceImpl();

  @override
  Future<CurrencyLocallyModel?> getCurrencyFromLocalDatabase() async {
    return await CacheHelper.instance.hiveGetDataById<CurrencyLocallyModel>(0);
  }

  @override
  Future<void> sendCurrencyToLocalDatabase({required Map<String, dynamic> currencies}) async {
    await CacheHelper.instance.hivePutData<CurrencyLocallyModel>(CurrencyLocallyModel(currencies: currencies));
  }
}
