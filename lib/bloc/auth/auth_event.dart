part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class LogIn extends AuthEvent {
  const LogIn({required this.email, required this.password});

  final String email;
  final String password;
}

class LogOut extends AuthEvent {}
