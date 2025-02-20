// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_util_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserUtilModelAdapter extends TypeAdapter<UserUtilModel> {
  @override
  final int typeId = 9;

  @override
  UserUtilModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserUtilModel(
      expandedTemperature: fields[0] as bool,
      expandedPulse: fields[1] as bool,
      expandedBloodPressure: fields[2] as bool,
      expandedPainLevel: fields[3] as bool,
      expandedFealGraph: fields[4] as bool,
      expandedWeightGraph: fields[5] as bool,
      expandedTemperatureGraph: fields[6] as bool,
      expandedPulseGraph: fields[7] as bool,
      expandedBloodPressureGraph: fields[8] as bool,
      expandedPainLevelGraph: fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserUtilModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.expandedTemperature)
      ..writeByte(1)
      ..write(obj.expandedPulse)
      ..writeByte(2)
      ..write(obj.expandedBloodPressure)
      ..writeByte(3)
      ..write(obj.expandedPainLevel)
      ..writeByte(4)
      ..write(obj.expandedFealGraph)
      ..writeByte(5)
      ..write(obj.expandedWeightGraph)
      ..writeByte(6)
      ..write(obj.expandedTemperatureGraph)
      ..writeByte(7)
      ..write(obj.expandedPulseGraph)
      ..writeByte(8)
      ..write(obj.expandedBloodPressureGraph)
      ..writeByte(9)
      ..write(obj.expandedPainLevelGraph);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserUtilModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
