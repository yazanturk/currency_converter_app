// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_locally_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyLocallyModelAdapter extends TypeAdapter<CurrencyLocallyModel> {
  @override
  final int typeId = 0;

  @override
  CurrencyLocallyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyLocallyModel(
      currencies: (fields[0] as Map).cast<String, num>(),
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyLocallyModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.currencies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyLocallyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
