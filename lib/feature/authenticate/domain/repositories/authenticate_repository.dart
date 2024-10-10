import 'package:habit_garden/core/data/params/authenticate_param.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/feature/authenticate/domain/entities/user_entity.dart';

abstract class AuthenticateRepository {
  Future<AppResult<UserEntity>> signInWithEmailAndPassword({
    required SignInParam signInParam,
  });

  Future<AppResult<UserEntity>> signUpWithEmailAndPassword({
    required SignUpParam signUpParam,
  });
}
