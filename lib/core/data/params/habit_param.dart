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

// "name":"reading",
// "description":"1 book per/week",
// "frequency":"6 times a week",
// "duration":"60 min",
// "priority":"HIGH",
// "user":"6705fa40412c1fa38fef0b60"

class HabitCreateParam {
  final String name;
  final String description;
  final String frequency;
  final String duration;
  final String priority;
  final String user;

  HabitCreateParam({
    required this.name,
    required this.description,
    required this.frequency,
    required this.duration,
    required this.priority,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'frequency': frequency,
      'duration': duration,
      'priority': priority,
      'user': user,
    };
  }
}
