part of 'edit_employee_bloc.dart';

abstract class EditEmployeeEvent extends Equatable {
  const EditEmployeeEvent();

  @override
  List<Object?> get props => [];
}

class EditEmployee extends EditEmployeeEvent {
  const EditEmployee({
    required this.employeeData,
    this.image,
    required this.isEmailChanged,
  });

  final Map<String, dynamic> employeeData;
  final bool isEmailChanged;
  final File? image;
}
