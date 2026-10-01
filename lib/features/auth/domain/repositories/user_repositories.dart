import 'package:app_scale/features/auth/domain/entities/user_entity.dart';

abstract class UserRepositories {
  Future<UserEntity> login({
    required String username,
    required String password,
  });

  Future<UserEntity> logout();

  Future<UserEntity> register({
    required String username,
    required String email,
    required String password,
  });
}
