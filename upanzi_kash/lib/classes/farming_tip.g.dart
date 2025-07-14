// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farming_tip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FarmingTipAdapter extends TypeAdapter<FarmingTip> {
  @override
  final int typeId = 2;

  @override
  FarmingTip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FarmingTip(
      id: fields[0] as String,
      titleEnglish: fields[1] as String,
      titleSwahili: fields[2] as String,
      contentEnglish: fields[3] as String,
      contentSwahili: fields[4] as String,
      categories: (fields[5] as List).cast<String>(),
      imagePaths: (fields[6] as List).cast<String>(),
      isSeasonal: fields[7] as bool,
      seasonMonths: (fields[8] as List).cast<String>(),
      targetGoals: (fields[9] as List).cast<String>(),
      createdAt: fields[10] as DateTime,
      isFavorite: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FarmingTip obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.titleEnglish)
      ..writeByte(2)
      ..write(obj.titleSwahili)
      ..writeByte(3)
      ..write(obj.contentEnglish)
      ..writeByte(4)
      ..write(obj.contentSwahili)
      ..writeByte(5)
      ..write(obj.categories)
      ..writeByte(6)
      ..write(obj.imagePaths)
      ..writeByte(7)
      ..write(obj.isSeasonal)
      ..writeByte(8)
      ..write(obj.seasonMonths)
      ..writeByte(9)
      ..write(obj.targetGoals)
      ..writeByte(10)
      ..write(obj.createdAt)
      ..writeByte(11)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmingTipAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
