// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'regular_task_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegularTaskModelAdapter extends TypeAdapter<RegularTaskModel> {
  @override
  final int typeId = 6;

  @override
  RegularTaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegularTaskModel(
      scheduleTime: fields[0] as String,
      alermId: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RegularTaskModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.scheduleTime)
      ..writeByte(1)
      ..write(obj.alermId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegularTaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
