// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poop_condition.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PoopConditionModelAdapter extends TypeAdapter<PoopConditionModel> {
  @override
  final int typeId = 16;

  @override
  PoopConditionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PoopConditionModel(
      poopConditionType: fields[0] as PoopConditionType,
      dayPeriodType: fields[1] as DayPeriodType,
    );
  }

  @override
  void write(BinaryWriter writer, PoopConditionModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.poopConditionType)
      ..writeByte(1)
      ..write(obj.dayPeriodType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoopConditionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
