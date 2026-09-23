class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});

  @override
  String toString() => 'ServerException: $message (code: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  CacheException({this.message = 'Cache failure'});
}

class NetworkException implements Exception {
  final String message;
  NetworkException({this.message = 'No internet connection'});
}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}
