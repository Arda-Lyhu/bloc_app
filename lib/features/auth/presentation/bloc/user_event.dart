part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoginSubmited extends UserEvent {
  final String username;
  final String password;

  const LoginSubmited({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class RegisterSubmited extends UserEvent {
  final String username;
  final String email;
  final String password;

  const RegisterSubmited({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [username, email, password];
}

class LogoutSubmited extends UserEvent {
  const LogoutSubmited();
}
