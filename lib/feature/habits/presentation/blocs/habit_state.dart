import 'package:habit_garden/feature/habits/domain/entities/habit_entity.dart';

enum GetAllHabitByUserIdEnum { initial, loading, loaded, error }

sealed class HabitState {
  const HabitState();
}

final class HabitInitial extends HabitState {
  const HabitInitial();
}

final class GetAllHabitByUserIdState extends HabitState {
  final GetAllHabitByUserIdEnum status;
  final List<HabitEntity> habits;
  final String errorMesssage;
  GetAllHabitByUserIdState({
    this.status = GetAllHabitByUserIdEnum.initial,
    this.habits = const [],
    this.errorMesssage = '',
  });

  GetAllHabitByUserIdState copyWith({
    GetAllHabitByUserIdEnum? status,
    List<HabitEntity>? habits,
    String? errorMesssage,
  }) {
    return GetAllHabitByUserIdState(
      status: status ?? this.status,
      habits: habits ?? this.habits,
      errorMesssage: errorMesssage ?? this.errorMesssage,
    );
  }
}
