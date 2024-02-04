import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_bloc.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_event.dart';
import 'package:currency_converter_app/future/currency/presentation/bloc/currency_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum CurrencyDirection { up, down }

class DropDownCustomWidget extends StatelessWidget {
  const DropDownCustomWidget({super.key, required this.state, required this.status});

  final CurrencyState state;
  final CurrencyDirection status;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.lightBlue.withOpacity(0.2),
        border: Border.all(color: Colors.lightBlue.withOpacity(0.8), width: 3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: DropdownButton<String>(
          focusColor: Colors.white,
          value: status == CurrencyDirection.up ? state.currencyUp : state.currencyDown,
          isExpanded: true,
          isDense: true,

          //elevation: 5,
          style: const TextStyle(color: Colors.black),
          itemHeight: 50,
          menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
          iconEnabledColor: Colors.black,
          items: [
            ...state.currencyModel.map(
              (key, value) {
                return MapEntry(
                  key,
                  DropdownMenuItem(
                    value: key,
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: 'https://flagcdn.com/16x12/${key.toLowerCase().toString().replaceRange(2, 3, '')}.png',
                          width: 20,
                          height: 20,
                          errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          key,
                          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).values,
          ],
          hint: const Text(
            "Please choose a language",
            style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onChanged: (value) {
            if (status == CurrencyDirection.up) {
              context.read<CurrencyBloc>().add(CurrencyEvent.changeCurrency(value ?? '', true));
            } else {
              context.read<CurrencyBloc>().add(CurrencyEvent.changeCurrency(value ?? '', false));
            }
          },
        ),
      ),
    );
  }
}
