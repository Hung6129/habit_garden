import 'package:habit_garden/core/data/params/habit_param.dart';

sealed class HabitEvent {}

class GetAllHabitByUserIdEvent extends HabitEvent {
  GetAllHabitByUserIdEvent();
}

class UpdateHabitProgressEvent extends HabitEvent {
  final String habitId;
  final bool completed;

  UpdateHabitProgressEvent({
    required this.habitId,
    required this.completed,
  });
}

class RefreshHabitListEvent extends HabitEvent {
  RefreshHabitListEvent();
}

class CreateHabitEvent extends HabitEvent {
  final HabitCreateParam habitCreateParam;

  CreateHabitEvent({
    required this.habitCreateParam,
  });
}
