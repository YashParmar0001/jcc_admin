import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'edit_employee_event.dart';
part 'edit_employee_state.dart';

class EditEmployeeBloc extends Bloc<EditEmployeeEvent, EditEmployeeState> {
  EditEmployeeBloc() : super(EditEmployeeInitial()) {
    on<EditEmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
