CurrencyModel deserializeCurrencyModel(Map<String, dynamic> json) => CurrencyModel.fromJson(json);

class CurrencyModel {
  Map<String, dynamic>? data;

  CurrencyModel({
    this.data,
  });

  CurrencyModel copyWith({
    Map<String, dynamic>? data,
  }) =>
      CurrencyModel(
        data: data ?? this.data,
      );

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      data: json['data'],
    );
  }
}
