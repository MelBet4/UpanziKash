import 'package:hive/hive.dart';

part 'farm_transaction.g.dart';

@HiveType(typeId: 1)
class FarmTransaction extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  bool isIncome;

  @HiveField(3)
  String category;

  @HiveField(4)
  double amount;

  @HiveField(5)
  String notes;

  @HiveField(6)
  String photoPath;

  @HiveField(7)
  String location;

  @HiveField(8)
  bool isMpesa;

  @HiveField(9)
  bool isSynced;

  @HiveField(10)
  DateTime createdAt;

  FarmTransaction({
    required this.id,
    required this.date,
    required this.isIncome,
    required this.category,
    required this.amount,
    required this.notes,
    required this.photoPath,
    required this.location,
    required this.isMpesa,
    this.isSynced = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'isIncome': isIncome,
      'category': category,
      'amount': amount,
      'notes': notes,
      'photoPath': photoPath,
      'location': location,
      'isMpesa': isMpesa,
      'isSynced': isSynced,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory FarmTransaction.fromMap(Map<String, dynamic> map) {
    return FarmTransaction(
      id: map['id'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      isIncome: map['isIncome'] ?? false,
      category: map['category'] ?? '',
      amount: map['amount']?.toDouble() ?? 0.0,
      notes: map['notes'] ?? '',
      photoPath: map['photoPath'] ?? '',
      location: map['location'] ?? '',
      isMpesa: map['isMpesa'] ?? false,
      isSynced: map['isSynced'] ?? false,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  FarmTransaction copyWith({
    String? id,
    DateTime? date,
    bool? isIncome,
    String? category,
    double? amount,
    String? notes,
    String? photoPath,
    String? location,
    bool? isMpesa,
    bool? isSynced,
    DateTime? createdAt,
  }) {
    return FarmTransaction(
      id: id ?? this.id,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      photoPath: photoPath ?? this.photoPath,
      location: location ?? this.location,
      isMpesa: isMpesa ?? this.isMpesa,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 