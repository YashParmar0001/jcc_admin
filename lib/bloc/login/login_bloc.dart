import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc_admin/model/employee_model.dart';
import 'package:jcc_admin/repositories/login_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(LoginInitial()) {
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  final LoginRepository _loginRepository;

  Future<void> _onLogIn(LogIn event, Emitter<LoginState> emit) async {
    emit(LoggingIn());
    final employee = await _loginRepository.login(event.email);

    if (employee == null) {
      emit(NotRegistered());
    }else {
      emit(LoggedIn(employee));
    }
  }

  void _onLogOut(LogOut event, Emitter<LoginState> emit) {
    emit(LoggedOut());
  }

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    dev.log(transition.toString(), name: 'User');
    super.onTransition(transition);
  }
}
