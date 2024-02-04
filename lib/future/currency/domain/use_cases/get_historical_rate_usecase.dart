import 'package:currency_converter_app/core/error/failures.dart';
import 'package:currency_converter_app/core/usecasses/usecasses.dart';
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHistoricalRateUseCase implements UseCases<Map<String, dynamic>, GetHistoricalRateParams> {
  final CurrencyRepository _currencyRepository;

  GetHistoricalRateUseCase(this._currencyRepository);

  @override
  Future<Either<Failures, Map<String, dynamic>>> call(GetHistoricalRateParams params) async {
    return await _currencyRepository.getHistoricalRate(params: params);
  }
}

class GetHistoricalRateParams extends Equatable {
  final String apiKey;
  final String date;
  final String baseCurrency;
  final String currencies;

  const GetHistoricalRateParams({
    required this.apiKey,
    required this.date,
    required this.baseCurrency,
    required this.currencies,
  });

  @override
  List<Object?> get props => [apiKey, date, baseCurrency, currencies];

  //query params
  Map<String, dynamic> toMap() {
    return {
      'apikey': apiKey,
      'date': date,
      'base_currency': baseCurrency,
      'currencies': currencies,
    };
  }
}
