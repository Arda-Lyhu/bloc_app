import 'package:app_scale/features/auth/domain/entities/user_entity.dart';
import 'package:app_scale/features/auth/domain/repositories/user_repositories.dart';

class UserLogin {
  final UserRepositories userRepositories;
  const UserLogin({required this.userRepositories});

  Future<UserEntity> call({
    required String username,
    required String password,
  }) async {
    return await userRepositories.login(
      username: username,
      password: password,
    );
  }
}
