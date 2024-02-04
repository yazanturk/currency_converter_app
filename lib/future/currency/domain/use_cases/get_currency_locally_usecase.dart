import 'package:currency_converter_app/core/error/failures.dart';
import 'package:currency_converter_app/core/service/no_params.dart';
import 'package:currency_converter_app/core/usecasses/usecasses.dart';
import 'package:currency_converter_app/future/currency/data/local/models/currency_locally_model.dart';
import 'package:currency_converter_app/future/currency/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetCurrencyLocallyUseCase implements UseCases<CurrencyLocallyModel, NoParams> {
  final CurrencyRepository _currencyRepository;

  GetCurrencyLocallyUseCase(this._currencyRepository);

  @override
  Future<Either<Failures, CurrencyLocallyModel?>> call(NoParams noParams) async {
    return await _currencyRepository.getCurrencyLocally();
  }
}
