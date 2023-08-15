// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchaseExam.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PurchaseCourseAdapter extends TypeAdapter<PurchaseCourse> {
  @override
  final int typeId = 0;

  @override
  PurchaseCourse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PurchaseCourse(
      courseId: fields[0] as int?,
      dateOfPurchase: fields[1] as String?,
      expirationDate: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PurchaseCourse obj) {
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
      other is PurchaseCourseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
