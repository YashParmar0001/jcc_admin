import 'dart:async';
import 'dart:developer' as dev;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc_admin/model/employee_model.dart';
import 'package:jcc_admin/repositories/employee_repository.dart';

part 'selected_employee_event.dart';

part 'selected_employee_state.dart';

class SelectedEmployeeBloc
    extends Bloc<SelectedEmployeeEvent, SelectedEmployeeState> {
  SelectedEmployeeBloc({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(SelectedEmployeeInitial()) {
    on<InitializeSelectedEmployee>(_onInitializeSelectedEmployee);
    on<LoadSelectedEmployee>(_onLoadSelectedEmployee);
    on<UpdateSelectedEmployee>(_onUpdateSelectedEmployee);
    on<AddEmployeeError>(_onAddEmployeeError);
  }

  final EmployeeRepository _employeeRepository;
  StreamSubscription? _employeeSubscription;

  void _onInitializeSelectedEmployee(InitializeSelectedEmployee event, Emitter<SelectedEmployeeState> emit,) {
    _employeeSubscription?.cancel();
    emit(SelectedEmployeeInitial());
  }

  void _onLoadSelectedEmployee(
    LoadSelectedEmployee event,
    Emitter<SelectedEmployeeState> emit,
  ) {
    emit(SelectedEmployeeLoading());
    _employeeSubscription?.cancel();
    try {
      _employeeSubscription = _employeeRepository.getSelectedEmployee(event.email).listen((employee) {
        if (employee == null) {
          add(AddEmployeeError());
        }else {
          add(UpdateSelectedEmployee(employee));
        }
      });
    } catch (e) {
      emit(SelectedEmployeeError(e.toString()));
    }
  }

  void _onAddEmployeeError(AddEmployeeError event, Emitter<SelectedEmployeeState> emit,) {
    emit(const SelectedEmployeeError('Not found!'));
  }

  void _onUpdateSelectedEmployee(
    UpdateSelectedEmployee event,
    Emitter<SelectedEmployeeState> emit,
  ) {
    emit(SelectedEmployeeLoaded(event.employee));
  }

  @override
  void onTransition(Transition<SelectedEmployeeEvent, SelectedEmployeeState> transition) {
    dev.log(transition.toString(), name: 'SelectedEmployee');
    super.onTransition(transition);
  }
}
