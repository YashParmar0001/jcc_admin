part of 'employee_register_bloc.dart';

abstract class EmployeeRegisterState extends Equatable {
  const EmployeeRegisterState();

  @override
  List<Object> get props => [];
}

class EmployeeRegisterInitial extends EmployeeRegisterState {}

class EmployeeRegistering extends EmployeeRegisterState {}

class EmployeeRegisterSuccess extends EmployeeRegisterState {
  const EmployeeRegisterSuccess(this.employeeId);
  final String employeeId;
}

class EmployeeRegisterFailure extends EmployeeRegisterState {
  const EmployeeRegisterFailure(this.error);

  final String error;
}