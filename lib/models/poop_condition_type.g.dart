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
        return PoopConditionType.severeConstipation;
      case 1:
        return PoopConditionType.mildConstipation;
      case 2:
        return PoopConditionType.nomarl;
      case 3:
        return PoopConditionType.normal2;
      case 4:
        return PoopConditionType.lackingFibre;
      case 5:
        return PoopConditionType.mildDiarrhea;
      case 6:
        return PoopConditionType.severeDiarrhea;
      default:
        return PoopConditionType.severeConstipation;
    }
  }

  @override
  void write(BinaryWriter writer, PoopConditionType obj) {
    switch (obj) {
      case PoopConditionType.severeConstipation:
        writer.writeByte(0);
        break;
      case PoopConditionType.mildConstipation:
        writer.writeByte(1);
        break;
      case PoopConditionType.nomarl:
        writer.writeByte(2);
        break;
      case PoopConditionType.normal2:
        writer.writeByte(3);
        break;
      case PoopConditionType.lackingFibre:
        writer.writeByte(4);
        break;
      case PoopConditionType.mildDiarrhea:
        writer.writeByte(5);
        break;
      case PoopConditionType.severeDiarrhea:
        writer.writeByte(6);
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
