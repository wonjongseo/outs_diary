// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hospital_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HospitalLogModelAdapter extends TypeAdapter<HospitalLogModel> {
  @override
  final int typeId = 2;

  @override
  HospitalLogModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HospitalLogModel(
      startTime: fields[2] as String?,
      dateTime: fields[3] as DateTime,
      hospitalName: fields[4] as String,
      imagesPath: (fields[5] as List).cast<String>(),
      pills: (fields[9] as List?)?.cast<String>(),
      officeName: fields[6] as String?,
      diseaseName: fields[7] as String?,
      diagnosis: fields[8] as String?,
    )
      ..id = fields[0] as String
      ..createdAt = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, HospitalLogModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.dateTime)
      ..writeByte(4)
      ..write(obj.hospitalName)
      ..writeByte(5)
      ..write(obj.imagesPath)
      ..writeByte(6)
      ..write(obj.officeName)
      ..writeByte(7)
      ..write(obj.diseaseName)
      ..writeByte(8)
      ..write(obj.diagnosis)
      ..writeByte(9)
      ..write(obj.pills);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HospitalLogModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
