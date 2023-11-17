part of 'selected_employee_bloc.dart';

abstract class SelectedEmployeeEvent extends Equatable {
  const SelectedEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class InitializeSelectedEmployee extends SelectedEmployeeEvent {}

class LoadSelectedEmployee extends SelectedEmployeeEvent {
  const LoadSelectedEmployee(this.email);
  final String email;
}

class UpdateSelectedEmployee extends SelectedEmployeeEvent {
  const UpdateSelectedEmployee(this.employee);
  final EmployeeModel employee;
}

class AddEmployeeError extends SelectedEmployeeEvent {}
