import 'package:app_scale/features/auth/domain/entities/user_entity.dart';
import 'package:app_scale/features/auth/domain/repositories/user_repositories.dart';

class UserLogout {
  final UserRepositories repository;

  UserLogout(this.repository);

  Future<UserEntity> call() async {
    return await repository.logout();
  }
}
