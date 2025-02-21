// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DiaryModelAdapter extends TypeAdapter<DiaryModel> {
  @override
  final int typeId = 0;

  @override
  DiaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DiaryModel(
      dateTime: fields[2] as DateTime,
      fealIndex: fields[3] as int,
      whatTodo: fields[5] as String?,
      imagePath: (fields[6] as List?)?.cast<String>(),
      painfulIndex: fields[8] as int?,
      donePillDayModels: (fields[4] as List?)?.cast<DonePillDayModel>(),
      poopConditions: (fields[9] as List?)?.cast<PoopConditionModel>(),
      health: fields[7] as HealthModel?,
    )
      ..id = fields[0] as String
      ..createdAt = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, DiaryModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.dateTime)
      ..writeByte(3)
      ..write(obj.fealIndex)
      ..writeByte(4)
      ..write(obj.donePillDayModels)
      ..writeByte(5)
      ..write(obj.whatTodo)
      ..writeByte(6)
      ..write(obj.imagePath)
      ..writeByte(7)
      ..write(obj.health)
      ..writeByte(8)
      ..write(obj.painfulIndex)
      ..writeByte(9)
      ..write(obj.poopConditions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
