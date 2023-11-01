part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {

}

class LoggingIn extends LoginState {

}

class NotRegistered extends LoginState {}

class LoggedIn extends LoginState {
  const LoggedIn(this.employee);

  final EmployeeModel employee;
}

class LoggedOut extends LoginState {

}
