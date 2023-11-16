part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class InitializeEmployee extends EmployeeEvent {}

class LoadEmployee extends EmployeeEvent {
  const LoadEmployee(this.department);
  final String department;
}

class UpdateEmployee extends EmployeeEvent {
  const UpdateEmployee(this.employeeList);

  final List<EmployeeModel> employeeList;
}