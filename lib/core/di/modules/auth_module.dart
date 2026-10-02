import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../../features/auth/data/datasources/user_remote_datasoure.dart';
import '../../../features/auth/data/repositories/user_repositories_impl.dart';
import '../../../features/auth/domain/repositories/user_repositories.dart';
import '../../../features/auth/domain/usecases/register.dart';
import '../../../features/auth/domain/usecases/user_login.dart';
import '../../../features/auth/domain/usecases/user_logout.dart';
import '../../../features/auth/presentation/bloc/user_bloc.dart';

/// Registers all auth-feature dependencies.
void registerAuthModule(GetIt sl) {
  // --- Data Sources ---
  sl.registerLazySingleton<UserRemoteDatasoure>(
    () => UserRemoteDatasoureImpl(dio: sl<Dio>()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<UserRepositories>(
    () => UserRepositoriesImpl(userRemoteDatasoure: sl()),
  );

  // --- Use Cases ---
  sl.registerLazySingleton(() => UserLoginUseCase(userRepositories: sl()));
  sl.registerLazySingleton(() => UserRegisterUseCase(sl()));
  sl.registerLazySingleton(() => UserLogoutUseCase(sl()));

  // --- BLoC ---
  sl.registerFactory(
    () => UserBloc(
      userLogin: sl(),
      userRegister: sl(),
      userLogout: sl(),
    ),
  );
}
