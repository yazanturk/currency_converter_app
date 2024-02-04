import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency_state.freezed.dart';

enum CurrencyStatus { init, loading, loaded, error }

enum ConvertCurrencyStatus { init, loading, loaded, error }

enum GetHistoricalRateStatus { init, loading, loaded, error }

@freezed
class CurrencyState with _$CurrencyState {
  const factory CurrencyState({
    @Default('USD') String currencyUp,
    @Default('EUR') String currencyDown,
    @Default(0.0) double amount,
    @Default(CurrencyStatus.init) CurrencyStatus currencyStatus,
    @Default(GetHistoricalRateStatus.init) GetHistoricalRateStatus getHistoricalRateStatus,
    @Default(ConvertCurrencyStatus.init) ConvertCurrencyStatus convertCurrencyStatus,
    @Default(0.00) double amountAfterConvert,
    @Default({}) Map<String, dynamic> currencyModel,
    @Default({}) Map<String, dynamic> historicalRate,
    @Default({}) Map<String, dynamic> convertedCurrency,
  }) = _CurrencyState;
}
