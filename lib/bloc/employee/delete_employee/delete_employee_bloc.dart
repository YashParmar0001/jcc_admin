import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc_admin/repositories/employee_repository.dart';

part 'delete_employee_event.dart';

part 'delete_employee_state.dart';

class DeleteEmployeeBloc
    extends Bloc<DeleteEmployeeEvent, DeleteEmployeeState> {
  DeleteEmployeeBloc({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(DeleteEmployeeInitial()) {
    on<DeleteEmployee>(_onDeleteEmployee);
  }

  final EmployeeRepository _employeeRepository;

  Future<void> _onDeleteEmployee(
    DeleteEmployee event,
    Emitter<DeleteEmployeeState> emit,
  ) async {
    emit(DeletingEmployee());
    final response = await _employeeRepository.removeEmployee(event.email);
    if (response != null) {
      dev.log('Error in employee deletion: $response', name: 'Employee');
      emit(EmployeeDeletionError(response));
    }else {
      emit(EmployeeDeleted());
    }
  }
}
