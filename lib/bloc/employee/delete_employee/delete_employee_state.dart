part of 'delete_employee_bloc.dart';

abstract class DeleteEmployeeState extends Equatable {
  const DeleteEmployeeState();

  @override
  List<Object> get props => [];
}

class DeleteEmployeeInitial extends DeleteEmployeeState {

}

class DeletingEmployee extends DeleteEmployeeState {}

class EmployeeDeleted extends DeleteEmployeeState {}

class EmployeeDeletionError extends DeleteEmployeeState {
  const EmployeeDeletionError(this.message);
  final String message;
}
