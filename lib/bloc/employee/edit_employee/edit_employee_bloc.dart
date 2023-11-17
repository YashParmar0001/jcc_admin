import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/employee_repository.dart';

part 'edit_employee_event.dart';

part 'edit_employee_state.dart';

class EditEmployeeBloc extends Bloc<EditEmployeeEvent, EditEmployeeState> {
  EditEmployeeBloc({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(EditEmployeeInitial()) {
    on<EditEmployee>(_onEditEmployee);
  }

  final EmployeeRepository _employeeRepository;

  Future<void> _onEditEmployee(
    EditEmployee event,
    Emitter<EditEmployeeState> emit,
  ) async {
    emit(EmployeeEditing());
    final employeeData = event.employeeData;

    if (event.isEmailChanged) {
      await _employeeRepository.removeEmployee(event.employeeData['oldEmail']);
    }

    final employee = await _employeeRepository.registerEmployee(
      employeeData,
      event.image,
    );
    if (employee != null) {
      emit(EmployeeEditSuccess(employee.email));
    } else {
      emit(const EmployeeEditFailure('Error while editing employee'));
    }
  }
}
