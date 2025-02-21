// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_expandtion_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IsExpandtionTypeAdapter extends TypeAdapter<IsExpandtionType> {
  @override
  final int typeId = 14;

  @override
  IsExpandtionType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IsExpandtionType.temperature;
      case 1:
        return IsExpandtionType.pulse;
      case 2:
        return IsExpandtionType.bloodPressure;
      case 3:
        return IsExpandtionType.painLevel;
      case 4:
        return IsExpandtionType.fealGraph;
      case 5:
        return IsExpandtionType.weightGraph;
      case 6:
        return IsExpandtionType.temperatureGraph;
      case 7:
        return IsExpandtionType.pulseGraph;
      case 8:
        return IsExpandtionType.bloodPressureGraph;
      case 9:
        return IsExpandtionType.painLevelGraph;
      case 10:
        return IsExpandtionType.poopCondition;
      default:
        return IsExpandtionType.temperature;
    }
  }

  @override
  void write(BinaryWriter writer, IsExpandtionType obj) {
    switch (obj) {
      case IsExpandtionType.temperature:
        writer.writeByte(0);
        break;
      case IsExpandtionType.pulse:
        writer.writeByte(1);
        break;
      case IsExpandtionType.bloodPressure:
        writer.writeByte(2);
        break;
      case IsExpandtionType.painLevel:
        writer.writeByte(3);
        break;
      case IsExpandtionType.fealGraph:
        writer.writeByte(4);
        break;
      case IsExpandtionType.weightGraph:
        writer.writeByte(5);
        break;
      case IsExpandtionType.temperatureGraph:
        writer.writeByte(6);
        break;
      case IsExpandtionType.pulseGraph:
        writer.writeByte(7);
        break;
      case IsExpandtionType.bloodPressureGraph:
        writer.writeByte(8);
        break;
      case IsExpandtionType.painLevelGraph:
        writer.writeByte(9);
        break;
      case IsExpandtionType.poopCondition:
        writer.writeByte(10);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IsExpandtionTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
