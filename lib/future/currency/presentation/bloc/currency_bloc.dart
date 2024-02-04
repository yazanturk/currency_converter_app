import 'package:currency_converter_app/core/service/no_params.dart';
import 'package:currency_converter_app/env/env.dart';
import 'package:currency_converter_app/extention_query.dart';
import 'package:currency_converter_app/future/currency/data/local/models/currency_locally_model.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/convert_currency_usecase.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/get_currency_locally_usecase.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/get_historical_rate_usecase.dart';
import 'package:currency_converter_app/future/currency/domain/use_cases/save_currency_locally_usecase.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_event.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_state.dart';
import 'package:currency_converter_app/service_locator.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_cases/get_currency_usecase.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyBloc() : super(const CurrencyState()) {
    on<CurrencyEvent>((event, emit) async {
      await event.when(
        fetchCurrency: () => _fetchCurrency(emit),
        changeCurrency: (currency, isUp) => _changeCurrency(emit, currency: currency, isUp: isUp),
        changeCurrencyDown: (currency) => _fetchCurrency(emit),
        convertCurrency: (amount) => _convertCurrency(emit, amount: amount),
        swapCurrency: () => _swapCurrency(emit),
        fetchHistoricalRate: () => _fetchHistoricalRate(emit),
        saveCurrencyLocally: (model) => _saveCurrencyLocally(emit, model: model),
        fetchCurrencyLocally: () => _fetchCurrencyLocally(emit),
      );
    });
  }

  static CurrencyBloc get(context) => BlocProvider.of(context);

  final GetCurrencyUseCase getCurrency = di.sl();
  final GetHistoricalRateUseCase getHistoricalRateUseCase = di.sl();

  final ConvertCurrencyUseCase convertCurrencyUseCase = di.sl();
  final SaveCurrencyLocallyUseCase saveCurrencyLocallyUseCase = di.sl();
  final GetCurrencyLocallyUseCase getCurrencyLocallyUseCase = di.sl();

  Future<void> _fetchCurrency(Emitter<CurrencyState> emit) async {
    emit(state.copyWith(currencyStatus: CurrencyStatus.loading));
    final result = await getCurrency(Env.key);
    result.fold(
      (l) => emit(state.copyWith(currencyStatus: CurrencyStatus.error)),
      (currencies) {
        emit(state.copyWith(
            currencyStatus: CurrencyStatus.loaded,
            currencyModel: currencies,
            currencyUp: currencies.keys.firstOrNull ?? 'USD',
            currencyDown: currencies.keys.lastOrNull ?? 'EUR'));
        add(CurrencyEvent.saveCurrencyLocally(model: CurrencyLocallyModel(currencies: currencies)));
      },
    );
  }

  Future<void> _fetchCurrencyLocally(Emitter<CurrencyState> emit) async {
    emit(state.copyWith(currencyStatus: CurrencyStatus.loading));
    final result = await getCurrencyLocallyUseCase(NoParams());
    result.fold(
      (l) => emit(state.copyWith(currencyStatus: CurrencyStatus.error)),
      (currencies) {
        if (currencies != null) {
          emit(state.copyWith(
              currencyStatus: CurrencyStatus.loaded,
              currencyModel: currencies.currencies,
              currencyUp: currencies.currencies.keys.firstOrNull ?? 'USD',
              currencyDown: currencies.currencies.keys.lastOrNull ?? 'EUR'));
        } else {
          add(const CurrencyEvent.fetchCurrency());
        }
      },
    );
  }

  _saveCurrencyLocally(Emitter<CurrencyState> emit, {required CurrencyLocallyModel model}) async {
    final result = await saveCurrencyLocallyUseCase(model.currencies);
    result.fold(
      (error) => emit(state.copyWith(currencyStatus: CurrencyStatus.error)),
      (currencies) {},
    );
  }

  Future<void> _changeCurrency(Emitter<CurrencyState> emit, {required String currency, required bool isUp}) async {
    if (isUp) {
      emit(state.copyWith(currencyUp: currency, amountAfterConvert: 0));
    } else {
      emit(state.copyWith(currencyDown: currency, amountAfterConvert: 0));
    }
  }

  Future<void> _convertCurrency(Emitter<CurrencyState> emit, {required double amount}) async {
    emit(state.copyWith(convertCurrencyStatus: ConvertCurrencyStatus.loading));
    final response = await convertCurrencyUseCase(ConvertCurrencyParams(
      currencies: '${state.currencyUp},${state.currencyDown}',
    ));

    response.fold(
      (error) {
        emit(state.copyWith(currencyStatus: CurrencyStatus.error, convertCurrencyStatus: ConvertCurrencyStatus.error));
      },
      (currencies) {
        emit(state.copyWith(
            convertCurrencyStatus: ConvertCurrencyStatus.loaded,
            convertedCurrency: currencies,
            amount: amount,
            amountAfterConvert: (currencies[state.currencyDown]) * amount));
      },
    );
  }

  Future<void> _swapCurrency(
    Emitter<CurrencyState> emit,
  ) async {
    if (state.amountAfterConvert > 0.0) {
      emit(state.copyWith(
          currencyUp: state.currencyDown,
          currencyDown: state.currencyUp,
          amountAfterConvert: state.convertedCurrency[state.currencyUp] * state.amount));
    } else {
      emit(state.copyWith(currencyUp: state.currencyDown, currencyDown: state.currencyUp));
    }
  }

  Future<void> _fetchHistoricalRate(Emitter<CurrencyState> emit) async {
    DateTime data = DateTime.now().subtract(const Duration(days: 7));

    emit(state.copyWith(currencyStatus: CurrencyStatus.loading));
    final result = await getHistoricalRateUseCase(GetHistoricalRateParams(
      apiKey: Env.key,
      date: data.toFormattedString(),
      baseCurrency: 'USD',
      currencies: 'EUR',
    ));
    result.fold(
      (l) => emit(state.copyWith(currencyStatus: CurrencyStatus.error)),
      (historicalRate) => emit(state.copyWith(currencyStatus: CurrencyStatus.loaded, historicalRate: historicalRate)),
    );
  }
}
