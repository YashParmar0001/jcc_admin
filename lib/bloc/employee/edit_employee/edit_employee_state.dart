part of 'edit_employee_bloc.dart';

abstract class EditEmployeeState extends Equatable {
  const EditEmployeeState();

  @override
  List<Object> get props => [];
}

class EditEmployeeInitial extends EditEmployeeState {

}

class EmployeeEditing extends EditEmployeeState {}

class EmployeeEditSuccess extends EditEmployeeState {
  const EmployeeEditSuccess(this.email);
  final String email;
}

class EmployeeEditFailure extends EditEmployeeState {
  const EmployeeEditFailure(this.error);

  final String error;
}
