import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc_admin/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  final AuthRepository _authRepository;

  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    try {
      final isSignedIn = await _authRepository.isSignedIn();
      if (isSignedIn) {
        final email = _authRepository.getCurrentUserEmail();

        emit(Authenticated(email));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> _onLogIn(LogIn event, Emitter<AuthState> emit) async {
    emit(Authenticating());
    final response = await _authRepository.loginWithEmailAndPassword(
      event.email,
      event.password,
    );

    if (response == null) {
      emit(Authenticated(_authRepository.getCurrentUserEmail()));
    } else {
      dev.log('Un authenticated user: $response', name: 'Auth');
      emit(UnAuthenticated());
    }
  }

  Future<void> _onLogOut(LogOut event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    emit(UnAuthenticated());
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    dev.log(transition.toString(), name: 'Auth');
    super.onTransition(transition);
  }
}
