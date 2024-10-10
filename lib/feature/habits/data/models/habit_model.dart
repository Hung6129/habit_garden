import 'package:habit_garden/feature/habits/domain/entities/habit_entity.dart';

class HabitModel extends HabitEntity {
  const HabitModel(
    super.id,
    super.name,
    super.description,
    super.frequency,
    super.duration,
    super.priority,
    super.user,
    super.createdAt,
    super.updatedAt,
  );

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      json['_id'],
      json['name'],
      json['description'],
      json['frequency'],
      json['duration'],
      json['priority'],
      json['user'],
      json['createdAt'],
      json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': super.id,
      'name': super.name,
      'description': super.description,
      'frequency': super.frequency,
      'duration': super.duration,
      'priority': super.priority,
      'user': super.user,
      'createdAt': super.createdAt,
      'updatedAt': super.updatedAt,
    };
  }
}
