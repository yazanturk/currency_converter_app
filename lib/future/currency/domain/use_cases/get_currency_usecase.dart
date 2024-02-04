import 'package:currency_converter_app/core/error/failures.dart';
import 'package:currency_converter_app/core/usecasses/usecasses.dart';
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCurrencyUseCase implements UseCases<Map<String, dynamic>, String> {
  final CurrencyRepository _currencyRepository;

  GetCurrencyUseCase(this._currencyRepository);

  @override
  Future<Either<Failures, Map<String, dynamic>>> call(String apiKey) async {
    return await _currencyRepository.getCurrency(apiKey: apiKey);
  }
}
