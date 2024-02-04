import 'package:bloc_test/bloc_test.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_bloc.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_event.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_state.dart';
import 'package:currency_converter_app/service_locator.dart' as di;
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.configureDependencies();
  late CurrencyBloc currencyBloc;

  setUp(() async {
    currencyBloc = CurrencyBloc();
  });

  group('description', () {
    blocTest(
      'emits [loading] when FetchCurrency is called',
      build: () => currencyBloc,
      act: (bloc) {
        bloc.add(const CurrencyEvent.fetchCurrency());
      },
      wait: const Duration(milliseconds: 300),
      expect: () => [
        const CurrencyState(
          currencyStatus: CurrencyStatus.loading,
        )
      ],
    );
    blocTest(
      'emits [USD] when ChangeCurrency is Changed',
      build: () => currencyBloc,
      act: (bloc) {
        bloc.add(const CurrencyEvent.changeCurrency('USD', true));
      },
      expect: () => [
        const CurrencyState(
          currencyUp: 'USD',
        )
      ],
    );
    blocTest(
      'emits [USD] when ChangeCurrency is Changed',
      build: () => currencyBloc,
      act: (bloc) {
        bloc.add(const CurrencyEvent.changeCurrency('USD', false));
      },
      expect: () => [
        const CurrencyState(
          currencyDown: 'USD',
        )
      ],
    );
    blocTest(
      'emits [USD] when ConvertCurrency is called',
      build: () => currencyBloc,
      act: (bloc) {
        bloc.add(const CurrencyEvent.convertCurrency(100));
      },
      seed: () => const CurrencyState(
        currencyUp: 'PHP',
        currencyDown: 'USD',
        convertedCurrency: {
          'PHP': 55,
          'USD': 1,
        },
        amount: 100,
      ),
      skip: 1,
      wait: const Duration(milliseconds: 500),
      tags: 'convertCurrency',
      expect: () => [
        const CurrencyState(
          amountAfterConvert: 100,
          convertedCurrency: {"PHP": 55.9296888807, "USD": 1},
          currencyUp: "PHP",
          currencyDown: "USD",
          convertCurrencyStatus: ConvertCurrencyStatus.loaded,
          amount: 100,
        )
      ],
    );
  });
}
//import 'package:bloc/bloc.dart';
// import 'package:currency_converter_app/future/currency/presentation/bloc/currency_event.dart';
// import 'package:currency_converter_app/future/currency/presentation/bloc/currency_state.dart';
//
// class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
//   CurrencyBloc() : super(const CurrencyState.initial()) {
//     on<CurrencyEvent>((event, emit) {
//       event.when(
//         fetchCurrency: () => emit(const CurrencyState.loading()),
//         changeCurrency: (currency) => emit(const CurrencyState.loading()),
//       );
//     });
//   }
//
//   // fetchCurrency() async {
//   //   emit(const CurrencyState.loading());
//   //   final result = await getCurrency(NoParams());
//   //   result.fold(
//   //     (failure) => emit(CurrencyState.error(failure.message)),
//   //     (currencies) => emit(CurrencyState.loaded(currencies)),
//   //   );
//   // }
// }
