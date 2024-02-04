import 'package:currency_converter_app/core/error/failures.dart';
import 'package:currency_converter_app/core/usecasses/usecasses.dart';
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConvertCurrencyUseCase implements UseCases<Map<String, dynamic>, ConvertCurrencyParams> {
  final CurrencyRepository _currencyRepository;

  ConvertCurrencyUseCase(this._currencyRepository);

  @override
  Future<Either<Failures, Map<String, dynamic>>> call(ConvertCurrencyParams params) async {
    return await _currencyRepository.convertCurrency(params: params);
  }
}

class ConvertCurrencyParams {
  final String currencies;

  ConvertCurrencyParams({required this.currencies});
}
