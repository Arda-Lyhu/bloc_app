import 'dart:core';

import '../../domain/usecases/register.dart';
import '../../domain/usecases/user_login.dart';
import '../../domain/usecases/user_logout.dart';
import '../../../../core/utils/app_logger.dart';
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
      AppLogger.info('UserBloc', 'Attempting login for "${event.username}"');
      await userLogin.call(username: event.username, password: event.password);
      AppLogger.info('UserBloc', 'Login success');
      emit(UserLoginSuccess());
    } catch (e, st) {
      AppLogger.error('UserBloc', 'Login failed', error: e, stackTrace: st);
      emit(UserLoginError(message: e.toString()));
    }
  }

  Future<void> _onRegisterSubmited(
      RegisterSubmited event, Emitter<UserState> emit) async {
    try {
      emit(UserRegisterLoading());
      AppLogger.info('UserBloc', 'Attempting register for "${event.username}"');
      await userRegister.call(
        username: event.username,
        email: event.email,
        password: event.password,
      );
      AppLogger.info('UserBloc', 'Register success');
      emit(UserRegisterSuccess());
    } catch (e, st) {
      AppLogger.error('UserBloc', 'Register failed', error: e, stackTrace: st);
      emit(UserRegisterError(message: e.toString()));
    }
  }

  Future<void> _onUserLogout(
      LogoutSubmited event, Emitter<UserState> emit) async {
    try {
      emit(UserLogoutLoading());
      AppLogger.info('UserBloc', 'Attempting logout');
      await userLogout.call();
      AppLogger.info('UserBloc', 'Logout success');
      emit(UserLogoutSuccess());
      emit(UserInitial());
    } catch (e, st) {
      emit(UserLogoutError(message: e.toString()));
      AppLogger.error('UserBloc', 'Logout failed', error: e, stackTrace: st);
    }
  }
}
