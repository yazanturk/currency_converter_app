import 'package:currency_converter_app/core/error/failures.dart';
import 'package:currency_converter_app/core/usecasses/usecasses.dart';
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveCurrencyLocallyUseCase implements UseCases<bool, Map<String, dynamic>> {
  final CurrencyRepository _currencyRepository;

  SaveCurrencyLocallyUseCase(this._currencyRepository);

  @override
  Future<Either<Failures, bool>> call(Map<String, dynamic> currency) async {
    return await _currencyRepository.saveCurrencyLocally(currencyMap: currency);
  }
}
