// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_location_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterLocationModelAdapter extends TypeAdapter<MasterLocationModel> {
  @override
  final int typeId = 1;

  @override
  MasterLocationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MasterLocationModel()
      ..address = fields[0] as String?
      ..lat = fields[1] as double?
      ..lng = fields[2] as double?
      ..timestamp = fields[3] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, MasterLocationModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.address)
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
      other is MasterLocationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
