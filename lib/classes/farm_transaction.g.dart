// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farm_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FarmTransactionAdapter extends TypeAdapter<FarmTransaction> {
  @override
  final int typeId = 1;

  @override
  FarmTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FarmTransaction(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      isIncome: fields[2] as bool,
      category: fields[3] as String,
      amount: fields[4] as double,
      notes: fields[5] as String,
      photoPath: fields[6] as String,
      location: fields[7] as String,
      isMpesa: fields[8] as bool,
      isSynced: fields[9] as bool,
      createdAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FarmTransaction obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.isIncome)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.amount)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.photoPath)
      ..writeByte(7)
      ..write(obj.location)
      ..writeByte(8)
      ..write(obj.isMpesa)
      ..writeByte(9)
      ..write(obj.isSynced)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
