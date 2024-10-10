import 'package:habit_garden/core/data/params/authenticate_param.dart';
import 'package:habit_garden/core/networks/api_provider.dart';
import 'package:habit_garden/core/networks/client_request.dart';
import 'package:habit_garden/core/networks/nets/app_response.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/core/networks/network_service.dart';
import 'package:habit_garden/feature/authenticate/data/models/user_model.dart';
import 'package:logger/logger.dart';

abstract class AuthenticateDatasourceRemote {
  Future<AppResult<UserModel>> signInWithEmailAndPassword({
    required SignInParam signInParam,
  });

  Future<AppResult<UserModel>> signUpWithEmailAndPassword({
    required SignUpParam signUpParam,
  });
}

class AuthenticateDatasourceRemoteImpl implements AuthenticateDatasourceRemote {
  final NetworkService networkService;

  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  AuthenticateDatasourceRemoteImpl(this.networkService);

  @override
  Future<AppResult<UserModel>> signInWithEmailAndPassword(
      {required SignInParam signInParam}) async {
    try {
      final response = await networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.login,
          method: HTTPMethod.post,
          body: signInParam.toJson(),
        ),
      );
      if (response is AppResultSuccess<AppResponse>) {
        final UserModel user = UserModel.fromJson(
          response.netData?.data,
        );
        return AppResult.success(user);
      }
      if (response is AppResultFailure) {
        return AppResult.failure(
          (response as AppResultFailure).exception,
        );
      }
      return AppResult.exceptionEmpty();
    } catch (e, str) {
      _logger.e('signInWithEmailAndPassword: $e $str');
      return AppResult.exceptionEmpty();
    }
  }

  @override
  Future<AppResult<UserModel>> signUpWithEmailAndPassword(
      {required SignUpParam signUpParam}) async {
    try {
      final response = await networkService.request(
        clientRequest: ClientRequest(
          url: ApiProvider.register,
          method: HTTPMethod.post,
          body: signUpParam.toJson(),
        ),
      );
      if (response is AppResultSuccess<AppResponse>) {
        // Note here is when the response is successful,
        // just return empty UserModel bc latter user have to sign in again
        //
        // there is no need to get user data from the response
        final UserModel user = UserModel.empty();
        return AppResult.success(user);
      }
      if (response is AppResultFailure) {
        return AppResult.failure(
          (response as AppResultFailure).exception,
        );
      }
      return AppResult.exceptionEmpty();
    } catch (e, str) {
      _logger.e('signUpWithEmailAndPassword: $e $str');
      return AppResult.exceptionEmpty();
    }
  }
}
