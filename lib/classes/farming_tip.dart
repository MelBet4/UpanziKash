import 'package:hive/hive.dart';

part 'farming_tip.g.dart';

@HiveType(typeId: 2)
class FarmingTip extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String titleEnglish;

  @HiveField(2)
  String titleSwahili;

  @HiveField(3)
  String contentEnglish;

  @HiveField(4)
  String contentSwahili;

  @HiveField(5)
  List<String> categories;

  @HiveField(6)
  List<String> imagePaths;

  @HiveField(7)
  bool isSeasonal;

  @HiveField(8)
  List<String> seasonMonths;

  @HiveField(9)
  List<String> targetGoals;

  @HiveField(10)
  DateTime createdAt;

  @HiveField(11)
  bool isFavorite;

  FarmingTip({
    required this.id,
    required this.titleEnglish,
    required this.titleSwahili,
    required this.contentEnglish,
    required this.contentSwahili,
    required this.categories,
    required this.imagePaths,
    required this.isSeasonal,
    required this.seasonMonths,
    required this.targetGoals,
    required this.createdAt,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titleEnglish': titleEnglish,
      'titleSwahili': titleSwahili,
      'contentEnglish': contentEnglish,
      'contentSwahili': contentSwahili,
      'categories': categories,
      'imagePaths': imagePaths,
      'isSeasonal': isSeasonal,
      'seasonMonths': seasonMonths,
      'targetGoals': targetGoals,
      'createdAt': createdAt.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }

  factory FarmingTip.fromMap(Map<String, dynamic> map) {
    return FarmingTip(
      id: map['id'] ?? '',
      titleEnglish: map['titleEnglish'] ?? '',
      titleSwahili: map['titleSwahili'] ?? '',
      contentEnglish: map['contentEnglish'] ?? '',
      contentSwahili: map['contentSwahili'] ?? '',
      categories: List<String>.from(map['categories'] ?? []),
      imagePaths: List<String>.from(map['imagePaths'] ?? []),
      isSeasonal: map['isSeasonal'] ?? false,
      seasonMonths: List<String>.from(map['seasonMonths'] ?? []),
      targetGoals: List<String>.from(map['targetGoals'] ?? []),
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String getTitle(String language) {
    return language == 'sw' ? titleSwahili : titleEnglish;
  }

  String getContent(String language) {
    return language == 'sw' ? contentSwahili : contentEnglish;
  }

  bool isRelevantForSeason() {
    if (!isSeasonal) return true;
    
    final currentMonth = DateTime.now().month;
    final monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return seasonMonths.contains(monthNames[currentMonth - 1]);
  }
} 