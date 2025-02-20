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
      temperatures: (fields[0] as List?)?.cast<double>(),
      basicTemperatures: (fields[1] as List?)?.cast<double>(),
      bloodPressures: fields[2] as BloodPressureModel?,
      weights: (fields[3] as List?)?.cast<double>(),
      pulses: (fields[4] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, HealthModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.temperatures)
      ..writeByte(1)
      ..write(obj.basicTemperatures)
      ..writeByte(2)
      ..write(obj.bloodPressures)
      ..writeByte(3)
      ..write(obj.weights)
      ..writeByte(4)
      ..write(obj.pulses);
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
