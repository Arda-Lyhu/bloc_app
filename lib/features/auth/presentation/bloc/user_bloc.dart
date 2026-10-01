import 'dart:core';

import 'package:app_scale/features/auth/domain/usecases/register.dart';
import 'package:app_scale/features/auth/domain/usecases/user_login.dart';
import 'package:app_scale/features/auth/domain/usecases/user_logout.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserLoginUseCase userLogin;
  final UserRegisterUseCase userRegister;
  final UserLogoutUseCase userLogout;

  UserBloc({
    required this.userLogin,
    required this.userRegister,
    required this.userLogout,
  }) : super(UserInitial()) {
    on<LoginSubmited>(_onUserLogin);
    on<RegisterSubmited>(_onRegisterSubmited);
    on<LogoutSubmited>(_onUserLogout);
  }

  Future<void> _onUserLogin(
      LoginSubmited event, Emitter<UserState> emit) async {
    try {
      emit(UserLoginLoading());
      await userLogin.call(username: event.username, password: event.password);
      emit(UserLoginSuccess());
    } catch (e) {
      emit(UserLoginError(message: e.toString()));
    }
  }

  Future<void> _onRegisterSubmited(
      RegisterSubmited event, Emitter<UserState> emit) async {
    try {
      emit(UserRegisterLoading());
      await userRegister.call(
        username: event.username,
        email: event.email,
        password: event.password,
      );
      emit(
        UserRegisterSuccess(),
      );
    } catch (e) {
      emit(
        UserRegisterError(message: e.toString()),
      );
    }
  }

  Future<void> _onUserLogout(
      LogoutSubmited event, Emitter<UserState> emit) async {
    try {
      emit(
        UserLogoutLoading(),
      );
      await userLogout.call();
      emit(
        UserLogoutSuccess(),
      );
    } catch (e) {
      emit(
        UserLogoutError(message: e.toString()),
      );
    }
  }
}
