// {
//     "habit":"67078fbc67e357a4120b301e",
//     "date":"2024-10-06",
//     "completed":true
// }
class HabitProgressParam {
  final String habit;
  final String date;
  final bool completed;

  HabitProgressParam({
    required this.habit,
    required this.date,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'habit': habit,
      'date': date,
      'completed': completed,
    };
  }
}
