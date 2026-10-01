import 'api_client.dart';

abstract class BaseRemoteDataSource {
  final ApiClient apiClient;

  BaseRemoteDataSource(this.apiClient);
}
