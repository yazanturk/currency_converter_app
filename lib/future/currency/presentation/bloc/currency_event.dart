import 'package:currency_converter_app/future/currency/data/local/models/currency_locally_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_event.freezed.dart';

@freezed
class CurrencyEvent with _$CurrencyEvent {
  const factory CurrencyEvent.fetchCurrency() = _FetchCurrency;
  const factory CurrencyEvent.fetchCurrencyLocally() = _FetchCurrencyLocally;
  const factory CurrencyEvent.saveCurrencyLocally({required CurrencyLocallyModel model}) = _SaveCurrencyLocally;

  const factory CurrencyEvent.fetchHistoricalRate() = _FetchHistoricalRate;
  const factory CurrencyEvent.changeCurrency(String currency, bool isUp) = _ChangeCurrency;
  const factory CurrencyEvent.changeCurrencyDown(String currency) = _ChangeCurrencyDown;
  const factory CurrencyEvent.swapCurrency() = _SwapCurrency;
  const factory CurrencyEvent.convertCurrency(double amount) = _ConverCurrency;
}
