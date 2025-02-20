// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 5;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      selectedPillDays: (fields[2] as List?)?.cast<WeekDayType>(),
      colorIndex: fields[4] as int?,
      tasks: (fields[5] as List?)?.cast<TaskModel>(),
      backgroundIndex: fields[6] as int?,
      fealIconIndex: fields[7] as int?,
      dayPeriodTypes: (fields[3] as List?)?.cast<DayPeriodType>(),
    )
      ..id = fields[0] as String
      ..createdAt = fields[1] as int
      ..userUtilModel = fields[8] as UserUtilModel;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.selectedPillDays)
      ..writeByte(3)
      ..write(obj.dayPeriodTypes)
      ..writeByte(4)
      ..write(obj.colorIndex)
      ..writeByte(5)
      ..write(obj.tasks)
      ..writeByte(6)
      ..write(obj.backgroundIndex)
      ..writeByte(7)
      ..write(obj.fealIconIndex)
      ..writeByte(8)
      ..write(obj.userUtilModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
