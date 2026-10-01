part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

// login states
class UserInitial extends UserState {}

class UserLoginLoading extends UserState {}

class UserLoginSuccess extends UserState {}

class UserLoginError extends UserState {
  final String message;

  const UserLoginError({required this.message});

  @override
  List<Object> get props => [message];
}

// register states
class UserRegisterLoading extends UserState {}

class UserRegisterSuccess extends UserState {}

class UserRegisterError extends UserState {
  final String message;

  const UserRegisterError({required this.message});

  @override
  List<Object> get props => [message];
}

// logout states
class UserLogoutLoading extends UserState {}

class UserLogoutSuccess extends UserState {}

class UserLogoutError extends UserState {
  final String message;

  const UserLogoutError({required this.message});

  @override
  List<Object> get props => [message];
}
