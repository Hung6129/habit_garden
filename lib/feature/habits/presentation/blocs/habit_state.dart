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

enum CreateHabitEnum { initial, loading, success, error }

final class CreateHabitState extends HabitState {
  final CreateHabitEnum status;
  final HabitEntity habit;
  final String errorMesssage;

  CreateHabitState({
    this.status = CreateHabitEnum.initial,
    this.habit = HabitEntity.empty,
    this.errorMesssage = '',
  });

  CreateHabitState copyWith({
    CreateHabitEnum? status,
    HabitEntity? habit,
    String? errorMesssage,
  }) {
    return CreateHabitState(
      status: status ?? this.status,
      habit: habit ?? this.habit,
      errorMesssage: errorMesssage ?? this.errorMesssage,
    );
  }
}
