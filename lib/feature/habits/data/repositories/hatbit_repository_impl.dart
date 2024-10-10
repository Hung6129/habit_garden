import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/feature/habits/data/datasource/habit_datasource_remote.dart';
import 'package:habit_garden/feature/habits/domain/entities/habit_entity.dart';
import 'package:habit_garden/feature/habits/domain/repositories/habit_repository.dart';

class HatbitRepositoryImpl implements HabitRepository {
  final HabitDatasourceRemote remoteDataSource;

  HatbitRepositoryImpl(this.remoteDataSource);
  @override
  Future<AppResult<List<HabitEntity>>> getAllHabitsByUserId(
      {required String userId}) async {
    return await remoteDataSource.getAllHabitsByUserId(userId: userId);
  }
}
