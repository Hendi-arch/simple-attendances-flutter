// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendances_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendancesModelAdapter extends TypeAdapter<AttendancesModel> {
  @override
  final int typeId = 2;

  @override
  AttendancesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AttendancesModel()
      ..name = fields[0] as String?
      ..lat = fields[1] as double?
      ..lng = fields[2] as double?
      ..timestamp = fields[3] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, AttendancesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lat)
      ..writeByte(2)
      ..write(obj.lng)
      ..writeByte(3)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendancesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
