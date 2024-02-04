import 'package:currency_converter_app/future/currency/data/local/models/currency_locally_model.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_bloc.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_event.dart';
import 'package:currency_converter_app/future/currency/presentation/pages/currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.configureDependencies();
  await openHive();
  runApp(const MyApp());
}

Future<void> openHive() async {
  final dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);
  Hive.registerAdapter(CurrencyLocallyModelAdapter());
}

Future<void> openHiveForUnitTest() async {
  Hive.init('1');
  // Hive.registerAdapter(CurrencyLocallyModelAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CurrencyBloc()
              ..add(const CurrencyEvent.fetchCurrencyLocally())
              ..add(const CurrencyEvent.fetchHistoricalRate())),
      ],
      child: const MaterialApp(
        title: 'Currency Converter App',
        home: CurrencyPage(),
      ),
    );
  }
}
