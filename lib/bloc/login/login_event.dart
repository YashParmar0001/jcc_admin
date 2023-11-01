part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LogIn extends LoginEvent {
  const LogIn({required this.email, required this.password});

  final String email;
  final String password;
}

class LogOut extends LoginEvent {

}
