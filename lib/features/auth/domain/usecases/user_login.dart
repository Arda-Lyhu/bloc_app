import '../../../../core/network/token_store.dart';
import '../../data/models/user_model.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repositories.dart';

class UserLoginUseCase {
  final UserRepositories userRepositories;
  UserLoginUseCase({required this.userRepositories});

  Future<UserEntity> call({
    required String username,
    required String password,
  }) async {
    final user = await userRepositories.login(
      username: username,
      password: password,
    );
    // Persist the access token so all subsequent API calls are authenticated.
    if (user is UserModel && user.accessToken.isNotEmpty) {
      TokenStore.instance.save(user.accessToken);
    }
    return user;
  }
}

