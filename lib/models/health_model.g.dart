// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthModelAdapter extends TypeAdapter<HealthModel> {
  @override
  final int typeId = 1;

  @override
  HealthModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthModel(
      temperature: fields[0] as double?,
      basicTemperature: fields[1] as double?,
      bloodPressure: fields[2] as double?,
      weight: fields[3] as double?,
      pulse: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, HealthModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.temperature)
      ..writeByte(1)
      ..write(obj.basicTemperature)
      ..writeByte(2)
      ..write(obj.bloodPressure)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.pulse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
