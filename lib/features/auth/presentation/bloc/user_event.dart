part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  final String username;
  final String password;
  const UserEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class LoginSubmited extends UserEvent {
  const LoginSubmited({
    required super.username,
    required super.password,
  });
}
