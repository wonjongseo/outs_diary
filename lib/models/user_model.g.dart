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
      selectedMorningLunchEvening: (fields[2] as List?)?.cast<int>(),
      selectedDays: (fields[3] as List?)?.cast<int>(),
      drinkPillAlerms: (fields[4] as List?)?.cast<AlermModel>(),
      backgroundIndex: fields[7] as int?,
      fealIconIndex: fields[8] as int?,
    )
      ..id = fields[0] as String
      ..createdAt = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.selectedMorningLunchEvening)
      ..writeByte(3)
      ..write(obj.selectedDays)
      ..writeByte(4)
      ..write(obj.drinkPillAlerms)
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
