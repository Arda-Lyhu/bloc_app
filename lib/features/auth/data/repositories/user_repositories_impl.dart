import 'package:app_scale/features/auth/data/datasources/user_remote_datasoure.dart';
import 'package:app_scale/features/auth/domain/entities/user_entity.dart';
import 'package:app_scale/features/auth/domain/repositories/user_repositories.dart';

class UserRepositoriesImpl implements UserRepositories {
  final UserRemoteDatasoure userRemoteDatasoure;

  UserRepositoriesImpl({required this.userRemoteDatasoure});

  @override
  Future<UserEntity> login(
      {required String username, required String password}) {
    return userRemoteDatasoure.loginUser(
      username: username,
      password: password,
    );
  }

  @override
  Future<UserEntity> logout() {
    return userRemoteDatasoure.logoutUser();
  }

  @override
  Future<UserEntity> register(
      {required String username,
      required String email,
      required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
