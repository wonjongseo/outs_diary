// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BloodPressureModelAdapter extends TypeAdapter<BloodPressureModel> {
  @override
  final int typeId = 10;

  @override
  BloodPressureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BloodPressureModel(
      max: (fields[0] as List?)?.cast<int>(),
      min: (fields[1] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, BloodPressureModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.max)
      ..writeByte(1)
      ..write(obj.min);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
