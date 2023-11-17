part of 'delete_employee_bloc.dart';

abstract class DeleteEmployeeEvent extends Equatable {
  const DeleteEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class DeleteEmployee extends DeleteEmployeeEvent {
  const DeleteEmployee(this.email);
  final String email;
}
