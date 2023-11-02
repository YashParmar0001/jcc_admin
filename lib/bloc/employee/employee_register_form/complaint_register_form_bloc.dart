import 'dart:async';
import 'dart:ffi';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:jcc_admin/constants/string_constants.dart';
import 'dart:developer' as dev;
class EmployeeRegisterFormBloc extends FormBloc<Map<String, dynamic>, String> {
  EmployeeRegisterFormBloc() {
    addFieldBlocs(
        fieldBlocs: [
          firstName,
          middleName,
          lastName,
          employeeId,
          phone,
          email,
          password,
          ward,
          department,
          type,
        ]
    );
  }

  final ward = SelectFieldBloc(items: CommonDataConstants.wardNameList.toList());
  final department = SelectFieldBloc(items: CommonDataConstants.departmentNameList.toList());
  final type = SelectFieldBloc(items: CommonDataConstants.employeetype.toList());

  final firstName = TextFieldBloc();
  final middleName = TextFieldBloc();
  final lastName = TextFieldBloc();
  final employeeId = TextFieldBloc();
  final phone = TextFieldBloc();
  final email = TextFieldBloc();
  final password = TextFieldBloc();

  @override
  FutureOr<void> onSubmitting() {
    try {
      final data = {
        'firstName' : firstName.value,
        'middleName' : middleName.value,
        'lastName' : lastName.value,
        'employeeId' : employeeId.value,
        'phone' : phone.value,
        'email' : email.value,
        'ward': ward.value,
        'department' : department.value,
        'type' : type.value,
        'password' : "898920",
      };
      emitSuccess(successResponse: data);
    }catch(e) {
      dev.log('Got error in complaint register: $e', name: 'Employee form bloc');
      emitFailure(failureResponse: 'Error: $e');
    }
  }
}