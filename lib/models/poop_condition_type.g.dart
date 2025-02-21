// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poop_condition_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PoopConditionTypeAdapter extends TypeAdapter<PoopConditionType> {
  @override
  final int typeId = 15;

  @override
  PoopConditionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PoopConditionType.korokoro;
      case 1:
        return PoopConditionType.hard;
      case 2:
        return PoopConditionType.nomarl;
      case 3:
        return PoopConditionType.soft;
      case 4:
        return PoopConditionType.likeMud;
      case 5:
        return PoopConditionType.likeWater;
      default:
        return PoopConditionType.korokoro;
    }
  }

  @override
  void write(BinaryWriter writer, PoopConditionType obj) {
    switch (obj) {
      case PoopConditionType.korokoro:
        writer.writeByte(0);
        break;
      case PoopConditionType.hard:
        writer.writeByte(1);
        break;
      case PoopConditionType.nomarl:
        writer.writeByte(2);
        break;
      case PoopConditionType.soft:
        writer.writeByte(3);
        break;
      case PoopConditionType.likeMud:
        writer.writeByte(4);
        break;
      case PoopConditionType.likeWater:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PoopConditionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
