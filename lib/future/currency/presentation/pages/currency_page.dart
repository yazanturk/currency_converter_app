import 'package:currency_converter_app/future/currency/presentation/bloc/currency_bloc.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_event.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_state.dart';
import 'package:currency_converter_app/future/currency/presentation/widgets/dropdown_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(builder: (context, state) {
      var bloc = CurrencyBloc.get(context);
      return Scaffold(
        appBar: AppBar(),
        body: state.currencyStatus == CurrencyStatus.loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.currencyStatus == CurrencyStatus.loaded
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: _key,
                          child: TextFormField(
                            controller: _controller,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'),
                              )
                            ],
                            textInputAction: TextInputAction.done,
                            validator: (value) => (value?.isNotEmpty ?? false) ? null : 'Please enter a amount to convert',
                            decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Amount'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: DropDownCustomWidget(
                                  state: state,
                                  status: CurrencyDirection.up,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  icon: const Icon(
                                    Icons.swap_horizontal_circle_outlined,
                                  ),
                                  onPressed: () {
                                    bloc.add(const CurrencyEvent.swapCurrency());
                                  },
                                  color: Colors.white,
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
                                    iconSize: MaterialStateProperty.all(25),
                                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: DropDownCustomWidget(
                                  state: state,
                                  status: CurrencyDirection.down,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if ((_key.currentState?.validate() ?? false) && state.amount != double.parse(_controller.text)) {
                              // prevent when user click convert button whit the same amount

                              bloc.add(CurrencyEvent.convertCurrency(double.parse(_controller.text)));
                            }
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 60)),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(color: Colors.blue, width: 2),
                              ),
                            ),
                          ),
                          child: const Text('Converter', style: TextStyle(color: Colors.blue, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Column(
                              children: [
                                const Text('Result:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text("\$${state.amountAfterConvert.toString()}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              ],
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('Historical Rate:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ListView(
                          padding: const EdgeInsets.all(0),
                          shrinkWrap: true,
                          children: [
                            ...state.historicalRate.entries.map((e) {
                              return ListTile(
                                contentPadding: const EdgeInsets.all(0),
                                minVerticalPadding: 0,
                                title: Row(
                                  children: [
                                    Text(
                                      e.key,
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      '(USD',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      size: 20,
                                    ),
                                    const Text(
                                      'EUR)',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                subtitle: Text("1 USD = \$${(e.value['EUR'] as num).toStringAsFixed(3)}", style: const TextStyle(fontSize: 14)),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
      );
    });
  }
}
