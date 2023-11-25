part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {

}

class Authenticating extends AuthState {

}

class Authenticated extends AuthState {
  const Authenticated(this.email);

  final String email;
}

class UnAuthenticated extends AuthState {}
