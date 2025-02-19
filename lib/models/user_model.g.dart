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
      selectedMorningLunchEvening: (fields[2] as List?)?.cast<String>(),
      selectedDays: (fields[3] as List?)?.cast<int>(),
      colorIndex: fields[4] as int?,
      tasks: (fields[5] as List?)?.cast<TaskModel>(),
      backgroundIndex: fields[7] as int?,
      fealIconIndex: fields[8] as int?,
    )
      ..id = fields[0] as String
      ..createdAt = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.selectedMorningLunchEvening)
      ..writeByte(3)
      ..write(obj.selectedDays)
      ..writeByte(4)
      ..write(obj.colorIndex)
      ..writeByte(5)
      ..write(obj.tasks)
      ..writeByte(7)
      ..write(obj.backgroundIndex)
      ..writeByte(8)
      ..write(obj.fealIconIndex);
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
