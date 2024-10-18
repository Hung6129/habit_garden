// "_id": "67078fbc67e357a4120b301e",
// "name": "typing",
// "description": "aiming to have 100wpm",
// "frequency": "5 times a week",
// "duration": "30 min",
// "priority": "HIGH",
// "user": "6705fa40412c1fa38fef0b60",
// "createdAt": "2024-10-10T08:26:36.629Z",
// "updatedAt": "2024-10-10T08:26:36.629Z",
// "__v": 0

import 'package:equatable/equatable.dart';

class HabitEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String frequency;
  final String duration;
  final String priority;
  final String user;
  final String createdAt;
  final String updatedAt;

  const HabitEntity(
    this.id,
    this.name,
    this.description,
    this.frequency,
    this.duration,
    this.priority,
    this.user,
    this.createdAt,
    this.updatedAt,
  );

  static const empty = HabitEntity(
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  );

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        frequency,
        duration,
        priority,
        user,
        createdAt,
        updatedAt,
      ];
}
