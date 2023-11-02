part of 'employee_bloc.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();

  @override
  List<Object> get props => [];
}


class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  const EmployeeLoaded(this.employeeList);

  final List<EmployeeModel> employeeList;

  @override
  List<Object> get props => [employeeList];
}

class EmployeeError extends EmployeeState {
  final String error;
  const EmployeeError(this.error);

  @override
  List<Object> get props => [error];
}

