import 'package:habit_garden/core/data/params/habit_param.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/feature/habits/domain/entities/habit_entity.dart';

abstract class HabitRepository {
  Future<AppResult<List<HabitEntity>>> getAllHabitsByUserId({
    required String userId,
  });

  Future<AppResult<HabitEntity>> createNewHabit({
    required HabitCreateParam param,
  });
}
