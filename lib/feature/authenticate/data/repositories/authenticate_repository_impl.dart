import 'package:habit_garden/core/data/params/authenticate_param.dart';
import 'package:habit_garden/core/networks/nets/app_result.dart';
import 'package:habit_garden/feature/authenticate/domain/entities/user_entity.dart';
import 'package:habit_garden/feature/authenticate/domain/repositories/authenticate_repository.dart';

import '../datasources/authenticate_datasource_remote.dart';

class AuthenticateRepositoryImpl implements AuthenticateRepository {
  final AuthenticateDatasourceRemote remoteDataSource;

  AuthenticateRepositoryImpl(this.remoteDataSource);

  @override
  Future<AppResult<UserEntity>> signInWithEmailAndPassword(
      {required SignInParam signInParam}) async {
    return await remoteDataSource.signInWithEmailAndPassword(
        signInParam: signInParam);
  }

  @override
  Future<AppResult<UserEntity>> signUpWithEmailAndPassword(
      {required SignUpParam signUpParam}) async {
    return await remoteDataSource.signUpWithEmailAndPassword(
        signUpParam: signUpParam);
  }
}
