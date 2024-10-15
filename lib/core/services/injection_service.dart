import 'package:get_it/get_it.dart';
import 'package:habit_garden/core/data/local/app_shared_pref.dart';
import 'package:habit_garden/core/networks/network_service.dart';
import 'package:habit_garden/core/services/app_services.dart';

import 'package:habit_garden/feature/authenticate/data/datasources/authenticate_datasource_remote.dart';
import 'package:habit_garden/feature/authenticate/data/repositories/authenticate_repository_impl.dart';
import 'package:habit_garden/feature/authenticate/domain/repositories/authenticate_repository.dart';
import 'package:habit_garden/feature/authenticate/domain/usecases/authenticate_usecase.dart';
import 'package:habit_garden/feature/authenticate/presentation/bloc/authenticate_bloc.dart';
import 'package:habit_garden/feature/habits/data/datasource/habit_datasource_remote.dart';
import 'package:habit_garden/feature/habits/data/repositories/hatbit_repository_impl.dart';
import 'package:habit_garden/feature/habits/domain/repositories/habit_repository.dart';
import 'package:habit_garden/feature/habits/domain/usecase/habit_usecase.dart';
import 'package:habit_garden/feature/habits/presentation/blocs/habit_bloc.dart';
import 'package:habit_garden/feature/home/blocs/main_bloc.dart';
import 'package:habit_garden/feature/walkthrough/bloc/walkthrough_bloc.dart';

final iS = GetIt.instance;

class InjectionService {
  static void registerServices() {
    /// Todo: Register services here
    iS.registerSingleton<AppSharedPref>(AppSharedPrefImpl());
    iS.registerLazySingleton<NetworkService>(() => NetworkServiceImpl());
    iS.registerSingleton<AppServices>(AppServicesImpl());

    /// Todo: Register datasources here
    iS.registerLazySingleton<AuthenticateDatasourceRemote>(
        () => AuthenticateDatasourceRemoteImpl(iS()));
    iS.registerLazySingleton<HabitDatasourceRemote>(
        () => HabitDatasourceRemoteImpl(iS()));

    /// Todo: Register repositories here
    iS.registerLazySingleton<AuthenticateRepository>(
      () => AuthenticateRepositoryImpl(iS()),
    );
    iS.registerLazySingleton<HabitRepository>(
      () => HatbitRepositoryImpl(iS()),
    );

    /// Todo: Register usecases here
    // Authenticate
    iS.registerFactory<AuthenticateUsecase>(() => AuthenticateUsecase(iS()));
    // Habit
    iS.registerFactory<HabitUsecase>(() => HabitUsecase(iS()));

    /// Todo: Register blocs here
    iS.registerFactory<WalkthroughBloc>(() => WalkthroughBloc());
    iS.registerFactory<AuthenticateBloc>(() => AuthenticateBloc(iS()));
    iS.registerFactory<HabitBloc>(() => HabitBloc(iS()));
    iS.registerFactory<MainBloc>(() => MainBloc());
  }
}
