// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pexam.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PEXAMAdapter extends TypeAdapter<PEXAM> {
  @override
  final int typeId = 1;

  @override
  PEXAM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PEXAM(
      courseId: fields[0] as int?,
      dateOfPurchase: fields[1] as String?,
      expirationDate: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PEXAM obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.courseId)
      ..writeByte(1)
      ..write(obj.dateOfPurchase)
      ..writeByte(2)
      ..write(obj.expirationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PEXAMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
