import '../entities/user_entity.dart';
import '../repositories/user_repositories.dart';

class UserRegisterUseCase {
  final UserRepositories repository;

  UserRegisterUseCase(this.repository);

  Future<UserEntity> call({
    required String username,
    required String email,
    required String password,
  }) async {
    return await repository.register(
      username: username,
      email: email,
      password: password,
    );
  }
}
