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
