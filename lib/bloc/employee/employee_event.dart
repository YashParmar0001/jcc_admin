part of 'employee_bloc.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();

  @override
  List<Object> get props => [];
}

class InitializeEmployee extends EmployeeEvent {}

class LoadEmployee extends EmployeeEvent {}

class UpdateEmployee extends EmployeeEvent {
  const UpdateEmployee(this.employeeList);

  final List<EmployeeModel> employeeList;
}