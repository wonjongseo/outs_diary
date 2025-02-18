// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alerm_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlermModelAdapter extends TypeAdapter<AlermModel> {
  @override
  final int typeId = 6;

  @override
  AlermModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlermModel(
      scheduleTime: fields[0] as String,
      alermId: fields[1] as int,
      isRegular: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AlermModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.scheduleTime)
      ..writeByte(1)
      ..write(obj.alermId)
      ..writeByte(2)
      ..write(obj.isRegular);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlermModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
