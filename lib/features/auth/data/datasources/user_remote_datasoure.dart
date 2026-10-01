import 'package:app_scale/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/base_remote_data_source.dart';

abstract class UserRemoteDatasoure {
  Future<UserModel> loginUser(
      {required String username, required String password});

  Future<UserModel> logoutUser();

  Future<UserModel> registerUser({
    required String username,
    required String email,
    required String password,
  });
}

class UserRemoteDatasoureImpl extends BaseRemoteDataSource
    implements UserRemoteDatasoure {
  UserRemoteDatasoureImpl({required Dio dio}) : super(ApiClient(dio));

  @override
  Future<UserModel> loginUser(
      {required String username, required String password}) async {
    return apiClient.post<UserModel>(
      path: ApiEndpoints.login,
      data: {
        'username': username,
        'password': password,
      },
      parser: (data) => UserModel.fromJson(data),
    );
  }

  @override
  Future<UserModel> logoutUser() async {
    return apiClient.post<UserModel>(
      path: ApiEndpoints.logout,
      parser: (data) => UserModel.fromJson(data),
    );
  }

  @override
  Future<UserModel> registerUser(
      {required String username,
      required String email,
      required String password}) async {
    return apiClient.post<UserModel>(
      path: ApiEndpoints.register,
      data: {
        'username': username,
        'email': email,
        'password': password,
      },
      parser: (data) => UserModel.fromJson(data),
    );
  }
}
