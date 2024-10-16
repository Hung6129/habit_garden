import 'package:habit_garden/core/data/params/habit_param.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/feature/habits/domain/entities/habit_entity.dart';
import 'package:habit_garden/feature/habits/domain/repositories/habit_repository.dart';

class HabitUsecase {
  final HabitRepository habitRepository;

  HabitUsecase(this.habitRepository);

  Future<AppResult<List<HabitEntity>>> getAllHabitsByUserId(
      {required String userId}) async {
    return await habitRepository.getAllHabitsByUserId(userId: userId);
  }

  Future<AppResult<HabitEntity>> createNewHabit(
      {required HabitCreateParam param}) async {
    return await habitRepository.createNewHabit(param: param);
  }
}
