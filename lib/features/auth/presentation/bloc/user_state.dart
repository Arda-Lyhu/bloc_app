part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoginLoading extends UserState {}

final class UserLoginError extends UserState {
  final String message;

  const UserLoginError({required this.message});

  @override
  List<Object> get props => [message];
}

final class UserLoginSuccess extends UserState {}
