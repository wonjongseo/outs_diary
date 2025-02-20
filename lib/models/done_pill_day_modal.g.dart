// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'done_pill_day_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DonePillDayModelAdapter extends TypeAdapter<DonePillDayModel> {
  @override
  final int typeId = 13;

  @override
  DonePillDayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DonePillDayModel(
      dayPeriod: fields[0] as DayPeriodType,
      isDone: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DonePillDayModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.dayPeriod)
      ..writeByte(1)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DonePillDayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
