import 'package:hive/hive.dart';

part 'currency_locally_model.g.dart';

@HiveType(typeId: 0)
class CurrencyLocallyModel extends HiveObject {
  @HiveField(0)
  Map<String, dynamic> currencies;

  CurrencyLocallyModel({required this.currencies});

  // create fromJson
  factory CurrencyLocallyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyLocallyModel(
      currencies: json,
    );
  }
}
