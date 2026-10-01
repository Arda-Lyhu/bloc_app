import 'dart:core';

import 'package:app_scale/features/auth/domain/usecases/user_login.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserLogin userLogin;
  UserBloc(this.userLogin) : super(UserInitial()) {
    on<LoginSubmited>(_onUserLogin);
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
}
