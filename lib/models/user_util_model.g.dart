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
    );
  }

  @override
  void write(BinaryWriter writer, UserUtilModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.expandedTemperature)
      ..writeByte(1)
      ..write(obj.expandedPulse)
      ..writeByte(2)
      ..write(obj.expandedBloodPressure);
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
