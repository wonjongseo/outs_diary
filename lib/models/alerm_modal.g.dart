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
      scheduleTime: fields[0] as String?,
      id: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AlermModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.scheduleTime)
      ..writeByte(1)
      ..write(obj.id);
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
