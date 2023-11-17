import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:jcc_admin/repositories/employee_repository.dart';

part 'employee_register_event.dart';

part 'employee_register_state.dart';

class EmployeeRegisterBloc
    extends Bloc<EmployeeRegisterEvent, EmployeeRegisterState> {
  EmployeeRegisterBloc({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(EmployeeRegisterInitial()) {
    on<RegisterEmployee>(_onRegisterEmployee);
  }

  final EmployeeRepository _employeeRepository;

  Future<void> _onRegisterEmployee(
      RegisterEmployee event, Emitter<EmployeeRegisterState> emit) async {
    emit(EmployeeRegistering());
    final employeeData = event.employeeData;
    print(employeeData.toString());
    final employee = await _employeeRepository.registerEmployee(
      employeeData,
      event.image,
    );
    if (employee != null) {
      emit(EmployeeRegisterSuccess(employee.employeeId));
    } else {
      emit(EmployeeRegisterFailure('Error while registering employee'));
    }
  }
}
