// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FarmerProfileAdapter extends TypeAdapter<FarmerProfile> {
  @override
  final int typeId = 0;

  @override
  FarmerProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FarmerProfile(
      name: fields[0] as String,
      farmName: fields[1] as String,
      location: fields[2] as String,
      farmSize: fields[3] as double,
      mainCrops: (fields[4] as List).cast<String>(),
      preferredLanguage: fields[5] as String,
      farmingGoal: fields[6] as String,
      profileImagePath: fields[7] as String,
      passcode: fields[8] as String?,
      farmType: fields[9] as String,
      createdAt: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, FarmerProfile obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.farmName)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.farmSize)
      ..writeByte(4)
      ..write(obj.mainCrops)
      ..writeByte(5)
      ..write(obj.preferredLanguage)
      ..writeByte(6)
      ..write(obj.farmingGoal)
      ..writeByte(7)
      ..write(obj.profileImagePath)
      ..writeByte(8)
      ..write(obj.passcode)
      ..writeByte(9)
      ..write(obj.farmType)
      ..writeByte(10)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmerProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
