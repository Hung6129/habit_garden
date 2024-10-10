import 'package:habit_garden/core/networks/api_provider.dart';
import 'package:habit_garden/core/networks/client_request.dart';
import 'package:habit_garden/core/networks/nets/app_response.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/core/networks/network_service.dart';
import 'package:habit_garden/feature/habits/data/models/habit_model.dart';
import 'package:logger/logger.dart';

abstract class HabitDatasourceRemote {
  Future<AppResult<List<HabitModel>>> getAllHabitsByUserId({
    required String userId,
  });
}

class HabitDatasourceRemoteImpl implements HabitDatasourceRemote {
  final NetworkService networkService;

  HabitDatasourceRemoteImpl(this.networkService);

  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  Future<AppResult<List<HabitModel>>> getAllHabitsByUserId(
      {required String userId}) async {
    try {
      final res = await networkService.request(
          clientRequest: ClientRequest(
        url: ApiProvider.getAllHabitsByUserId(userId),
        method: HTTPMethod.get,
      ));
      if (res is AppResultSuccess<AppResponse>) {
        final List<HabitModel> habits = (res.netData?.data as List<HabitModel>)
            .map((e) => HabitModel.fromJson(e.toJson()))
            .toList();
        _logger.d('getAllHabitsByUserId: $habits');
        return AppResult.success(habits);
      }
      if (res is AppResultFailure) {
        _logger
            .e('getAllHabitsByUserId: ${(res as AppResultFailure).exception}');
        return AppResult.failure((res as AppResultFailure).exception);
      }
      return AppResult.exceptionEmpty();
    } catch (e) {
      _logger.e('getAllHabitsByUserId: $e');
      return AppResult.exceptionEmpty();
    }
  }
}
