import 'package:dio/dio.dart';

import '../errors/exceptions.dart';
import '../utils/app_logger.dart';

class ApiClient {
  final Dio dio;

  const ApiClient(this.dio);

  static Dio createDio({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 10),
    Duration receiveTimeout = const Duration(seconds: 10),
    String? Function()? tokenProvider,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = tokenProvider?.call();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          AppLogger.network(
            method: options.method,
            url: '${options.baseUrl}${options.path}',
            body: options.data,
            headers: options.queryParameters.isNotEmpty
                ? options.queryParameters
                : null,
          );
          handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.network(
            method: response.requestOptions.method,
            url: '${response.requestOptions.baseUrl}${response.requestOptions.path}',
            statusCode: response.statusCode,
            response: response.data,
          );
          handler.next(response);
        },
        onError: (DioException err, handler) {
          AppLogger.network(
            method: err.requestOptions.method,
            url: '${err.requestOptions.baseUrl}${err.requestOptions.path}',
            statusCode: err.response?.statusCode,
            error: err.message,
          );
          handler.next(err);
        },
      ),
    );

    return dio;
  }

  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
    Options? options,
  }) {
    return request<T>(
      path: path,
      method: 'GET',
      queryParameters: queryParameters,
      parser: parser,
      options: options,
    );
  }

  Future<T> post<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
    Options? options,
  }) {
    return request<T>(
      path: path,
      method: 'POST',
      data: data,
      queryParameters: queryParameters,
      parser: parser,
      options: options,
    );
  }

  Future<T> put<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
    Options? options,
  }) {
    return request<T>(
      path: path,
      method: 'PUT',
      data: data,
      queryParameters: queryParameters,
      parser: parser,
      options: options,
    );
  }

  Future<T> patch<T>({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic data) parser,
    Options? options,
  }) {
    return request<T>(
      path: path,
      method: 'PATCH',
      data: data,
      queryParameters: queryParameters,
      parser: parser,
      options: options,
    );
  }

  Future<T> delete<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    required T Function(dynamic data) parser,
    Options? options,
  }) {
    return request<T>(
      path: path,
      method: 'DELETE',
      data: data,
      queryParameters: queryParameters,
      parser: parser,
      options: options,
    );
  }

  Future<T> request<T>({
    required String path,
    required String method,
    required T Function(dynamic data) parser,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    try {
      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: (options ?? Options()).copyWith(
          method: method,
          contentType: 'application/json',
        ),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return parser(response.data);
      }

      throw ServerException(
        message: response.statusMessage ?? 'Request failed',
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        throw NetworkException(message: 'No internet connection');
      }

      final message = error.response?.data is Map
          ? (error.response?.data['message'] ??
              error.message ??
              'Request failed')
          : (error.message ?? 'Request failed');

      throw ServerException(
        message: message,
        statusCode: error.response?.statusCode,
      );
    }
  }
}
