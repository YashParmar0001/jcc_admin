part of 'selected_employee_bloc.dart';

abstract class SelectedEmployeeState extends Equatable {
  const SelectedEmployeeState();

  @override
  List<Object> get props => [];
}

class SelectedEmployeeInitial extends SelectedEmployeeState {

}

class SelectedEmployeeLoading extends SelectedEmployeeState {}

class SelectedEmployeeLoaded extends SelectedEmployeeState {
  const SelectedEmployeeLoaded(this.employee);

  final EmployeeModel employee;

  @override
  List<Object> get props => [employee];
}

class SelectedEmployeeError extends SelectedEmployeeState {
  const SelectedEmployeeError(this.message);

  final String message;
}
