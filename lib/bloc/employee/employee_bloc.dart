import 'dart:async';
import 'dart:developer' as dev;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jcc_admin/repositories/employee_repository.dart';
import 'package:jcc_admin/model/employee_model.dart';
part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc({required EmployeeRepository employeeRepository})
      : _employeeRepository = employeeRepository,
        super(EmployeeInitial()) {
    on<LoadEmployee>(_onLoadEmployee);
    on<UpdateEmployee>(_onUpdateEmployee);
    on<InitializeEmployee>(_onInitializeEmployee);
  }

  final EmployeeRepository _employeeRepository;
  StreamSubscription? _employeeSubscription;

  void _onInitializeEmployee(InitializeEmployee event, Emitter<EmployeeState> emit,) {
    _employeeSubscription?.cancel();
    emit(EmployeeInitial());
  }

  FutureOr<void> _onLoadEmployee(
      LoadEmployee event,
      Emitter<EmployeeState> emit,
      ) {
    _employeeSubscription?.cancel();

    try {
      _employeeSubscription =
          _employeeRepository.getEmployeeList(event.department).listen((list) {
            dev.log('Updating employee list', name: 'Employee');
            add(UpdateEmployee(list));
          });
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  FutureOr<void> _onUpdateEmployee(
      UpdateEmployee event,
      Emitter<EmployeeState> emit,
      ) {
    emit(EmployeeLoaded(event.employeeList));
  }

  @override
  void onTransition(Transition<EmployeeEvent, EmployeeState> transition) {
    super.onTransition(transition);
    dev.log(transition.toString(), name: "Employee");
  }
}