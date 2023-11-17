part of 'employee_register_bloc.dart';

abstract class EmployeeRegisterEvent extends Equatable {
  const EmployeeRegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmployee extends EmployeeRegisterEvent {
  const RegisterEmployee({required this.employeeData, required this.image});

  final Map<String, dynamic> employeeData;
  final File image;
}
