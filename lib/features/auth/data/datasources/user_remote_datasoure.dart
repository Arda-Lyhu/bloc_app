import 'package:app_scale/features/auth/data/models/user_model.dart';
import 'package:dio/dio.dart';

abstract class UserRemoteDatasoure {
  Future<UserModel> loginUser(
      {required String username, required String password});
}

class UserRemoteDatasoureImpl implements UserRemoteDatasoure {
  final Dio dio;

  UserRemoteDatasoureImpl({required this.dio});
  @override
  Future<UserModel> loginUser(
      {required String username, required String password}) async {
    final response = await dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
      options: Options(contentType: 'application/json'),
    );
    return UserModel.fromJson(response.data);
  }
}
