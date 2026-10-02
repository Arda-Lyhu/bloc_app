import '../../../../core/network/token_store.dart';
import '../../../../core/utils/app_logger.dart';
import '../repositories/user_repositories.dart';

class UserLogoutUseCase {
  final UserRepositories repository;

  UserLogoutUseCase(this.repository);

  Future<void> call() async {
    try {
      if (TokenStore.instance.token != null &&
          TokenStore.instance.token!.isNotEmpty) {
        await repository.logout();
      }
    } catch (e, st) {
      AppLogger.error('UserLogoutUseCase', 'Logout failed',
          error: e, stackTrace: st);
    } finally {
      TokenStore.instance.clear();
    }
  }
}
