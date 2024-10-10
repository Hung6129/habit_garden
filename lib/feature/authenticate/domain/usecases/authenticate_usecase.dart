import 'package:habit_garden/core/data/params/authenticate_param.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/feature/authenticate/domain/entities/user_entity.dart';

import '../repositories/authenticate_repository.dart';

class AuthenticateUsecase {
  final AuthenticateRepository repository;

  AuthenticateUsecase(this.repository);

  Future<AppResult<UserEntity>> signInWithEmailAndPassword({
    required SignInParam signInParam,
  }) async {
    return await repository.signInWithEmailAndPassword(
      signInParam: signInParam,
    );
  }

  Future<AppResult<UserEntity>> signUpWithEmailAndPassword({
    required SignUpParam signUpParam,
  }) async {
    return await repository.signUpWithEmailAndPassword(
      signUpParam: signUpParam,
    );
  }
}
