import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../config/app_config.dart';
import '../../network/api_client.dart';
import '../../network/token_store.dart';

/// Registers all network-level dependencies.
void registerNetworkModule(GetIt sl) {
  sl.registerLazySingleton<Dio>(
    () => ApiClient.createDio(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: AppConfig.connectTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      tokenProvider: () => TokenStore.instance.token,
    ),
  );
}
