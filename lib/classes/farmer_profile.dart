import 'package:hive/hive.dart';

part 'farmer_profile.g.dart';

@HiveType(typeId: 0)
class FarmerProfile extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String farmName;

  @HiveField(2)
  String location;

  @HiveField(3)
  double farmSize;

  @HiveField(4)
  List<String> mainCrops;

  @HiveField(5)
  String preferredLanguage;

  @HiveField(6)
  String farmingGoal;

  @HiveField(7)
  String profileImagePath;

  @HiveField(8)
  String? passcode;

  @HiveField(9)
  String farmType;

  @HiveField(10)
  DateTime createdAt;

  FarmerProfile({
    required this.name,
    required this.farmName,
    required this.location,
    required this.farmSize,
    required this.mainCrops,
    required this.preferredLanguage,
    required this.farmingGoal,
    required this.profileImagePath,
    this.passcode,
    required this.farmType,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'farmName': farmName,
      'location': location,
      'farmSize': farmSize,
      'mainCrops': mainCrops,
      'preferredLanguage': preferredLanguage,
      'farmingGoal': farmingGoal,
      'profileImagePath': profileImagePath,
      'passcode': passcode,
      'farmType': farmType,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory FarmerProfile.fromMap(Map<String, dynamic> map) {
    return FarmerProfile(
      name: map['name'] ?? '',
      farmName: map['farmName'] ?? '',
      location: map['location'] ?? '',
      farmSize: map['farmSize']?.toDouble() ?? 0.0,
      mainCrops: List<String>.from(map['mainCrops'] ?? []),
      preferredLanguage: map['preferredLanguage'] ?? 'en',
      farmingGoal: map['farmingGoal'] ?? 'subsistence',
      profileImagePath: map['profileImagePath'] ?? '',
      passcode: map['passcode'],
      farmType: map['farmType'] ?? 'mixed',
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
} 