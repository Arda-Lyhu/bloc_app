abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure(super.message, {this.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Please check your internet connection']);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}
